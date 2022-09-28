import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/rendering.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_base/values/constants.dart';

class CustomPageWidget extends StatefulWidget {
  CustomPageWidget({
    Key? key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController? controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    List<Widget> this.items = const [],
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.aspectRatio = 16 / 9,
    this.showPaginationDots = true,
    required this.viewportDirection,
  })  : assert(allowImplicitScrolling != null),
        controller = controller ?? _defaultPageController,
        childrenDelegate = SliverChildListDelegate(items),
        super(key: key);

  CustomPageWidget.builder({
    Key? key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController? controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    required IndexedWidgetBuilder itemBuilder,
    List<Widget> this.items = const [],
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.aspectRatio = 16 / 9,
    this.showPaginationDots = true,
    required this.viewportDirection,
  })  : assert(allowImplicitScrolling != null),
        controller = controller ?? _defaultPageController,
        childrenDelegate =
            SliverChildBuilderDelegate(itemBuilder, childCount: items.length),
        super(key: key);

  CustomPageWidget.custom({
    Key? key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController? controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    required this.childrenDelegate,
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.aspectRatio = 16 / 9,
    this.showPaginationDots = true,
    this.items,
    required this.viewportDirection,
  })  : assert(childrenDelegate != null),
        assert(allowImplicitScrolling != null),
        controller = controller ?? _defaultPageController,
        super(key: key);

  final bool allowImplicitScrolling;
  final String? restorationId;
  final Axis scrollDirection;
  final bool reverse;
  final viewportDirection;
  final PageController controller;
  final ScrollPhysics? physics;
  final bool pageSnapping;
  final ValueChanged<int>? onPageChanged;
  final SliverChildDelegate childrenDelegate;
  final DragStartBehavior dragStartBehavior;
  final double aspectRatio; // Aspect Ratio
  final bool showPaginationDots;
  final List<Widget>? items; // List items

  @override
  _CustomPageWidgetState createState() => _CustomPageWidgetState();
}

class _CustomPageWidgetState extends State<CustomPageWidget> {
  int _lastReportedPage = 0;

  @override
  void initState() {
    super.initState();
    _lastReportedPage = widget.controller.initialPage;
  }

  AxisDirection? _getDirection(BuildContext context) {
    switch (widget.scrollDirection) {
      case Axis.horizontal:
        assert(debugCheckHasDirectionality(context));
        final TextDirection textDirection = Directionality.of(context);
        final AxisDirection axisDirection =
            textDirectionToAxisDirection(textDirection);
        return widget.reverse
            ? flipAxisDirection(axisDirection)
            : axisDirection;
      case Axis.vertical:
        return widget.reverse ? AxisDirection.up : AxisDirection.down;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final itemWidth = Utils.getWidth() * widget.controller.viewportFraction;
    final containerHeight = itemWidth / widget.aspectRatio;
    final AxisDirection axisDirection = _getDirection(context)!;
    final ScrollPhysics physics = _ForceImplicitScrollPhysics(
      allowImplicitScrolling: widget.allowImplicitScrolling,
    ).applyTo(widget.pageSnapping
        ? _kPagePhysics.applyTo(widget.physics)
        : widget.physics);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.depth == 0 &&
            notification is ScrollUpdateNotification) {
          final PageMetrics metrics = notification.metrics as PageMetrics;
          final int currentPage = metrics.page!.round();
          if (currentPage != _lastReportedPage) {
            setState(() {
              _lastReportedPage = currentPage;
              if (_lastReportedPage == widget.items!.length - 1 &&
                  widget.controller.position.userScrollDirection ==
                      ScrollDirection.reverse) {
                // final Widget first = widget.items.removeAt(0);
                // widget.items.add(first);
              }
            });
            if (!Utils.isNull(widget.onPageChanged))
              widget.onPageChanged!(currentPage);
          }
        }
        return false;
      },
      child: Stack(
        children: [
          Container(
            height: containerHeight + Constants.padding16,
            padding: EdgeInsets.symmetric(vertical: Constants.padding8),
            child: Scrollable(
              dragStartBehavior: widget.dragStartBehavior,
              axisDirection: axisDirection,
              controller: widget.controller,
              physics: physics,
              restorationId: widget.restorationId,
              viewportBuilder: (BuildContext context, ViewportOffset position) {
                return Viewport(
                  cacheExtent: widget.allowImplicitScrolling ? 1.0 : 0.0,
                  cacheExtentStyle: CacheExtentStyle.viewport,
                  axisDirection: axisDirection,
                  offset: position,
                  slivers: [
                    SliverFillViewport(
                      viewportFraction: widget.controller.viewportFraction,
                      delegate: widget.childrenDelegate,
                      padEnds: widget.viewportDirection,
                    ),
                  ],
                );
              },
            ),
          ),
          widget.showPaginationDots
              ? Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.items!.map((item) {
                      int index = widget.items!.indexOf(item);
                      return Container(
                        width: 16.0,
                        height: 4.0,
                        margin: EdgeInsets.symmetric(
                          horizontal: 1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Constants.cornerRadius),
                          shape: BoxShape.rectangle,
                          color: _lastReportedPage == index
                              ? Color.fromRGBO(255, 255, 255, 0.9)
                              : Color.fromRGBO(255, 255, 255, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description
        .add(EnumProperty<Axis>('scrollDirection', widget.scrollDirection));
    description.add(
        FlagProperty('reverse', value: widget.reverse, ifTrue: 'reversed'));
    description.add(DiagnosticsProperty<PageController>(
        'controller', widget.controller,
        showName: false));
    description.add(DiagnosticsProperty<ScrollPhysics>(
        'physics', widget.physics,
        showName: false));
    description.add(FlagProperty('pageSnapping',
        value: widget.pageSnapping, ifFalse: 'snapping disabled'));
    description.add(FlagProperty('allowImplicitScrolling',
        value: widget.allowImplicitScrolling,
        ifTrue: 'allow implicit scrolling'));
  }
}

final PageController _defaultPageController = PageController();
const PageScrollPhysics _kPagePhysics = PageScrollPhysics();

class _ForceImplicitScrollPhysics extends ScrollPhysics {
  const _ForceImplicitScrollPhysics({
    required this.allowImplicitScrolling,
    ScrollPhysics? parent,
  })  : assert(allowImplicitScrolling != null),
        super(parent: parent);

  @override
  _ForceImplicitScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _ForceImplicitScrollPhysics(
      allowImplicitScrolling: allowImplicitScrolling,
      parent: buildParent(ancestor),
    );
  }

  @override
  final bool allowImplicitScrolling;
}
