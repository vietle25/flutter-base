import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/values/extend_theme.dart';
import 'package:get/get.dart';

@immutable
class ExpandableFab extends StatefulWidget {
  final bool? initialOpen;
  final double distance;
  final List<Widget> children;
  final Widget? icon;

  const ExpandableFab({
    key,
    this.initialOpen,
    required this.distance,
    required this.children,
    this.icon,
  });

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  bool _open = false;
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTapToOpenFab() {
    final theme = Theme.of(Get.context!);
    final ExtendTheme extendTheme = theme.extension<ExtendTheme>()!;
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: theme.primaryColor,
            child: widget.icon ??
                Icon(
                  Icons.add,
                  color: extendTheme.iconSecondColor,
                ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    //
    // for (var i = 0, angleInDegrees = 0.0;
    //     i < count;
    //     i++, angleInDegrees += step) {
    //   children.add(
    //     _ExpandingActionButton(
    //       directionInDegrees: angleInDegrees,
    //       maxDistance: widget.distance,
    //       progress: _expandAnimation,
    //       child: widget.children[i],
    //     ),
    //   );
    // }
    final step = 72.0;
    for (var i = 0, distance = 72.0; i < count; i++, distance += step) {
      children.add(
        _ExpandingActionButton(
          // directionInDegrees: angleInDegrees,
          distance: distance,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
    required this.distance,
  });

  final double? directionInDegrees;
  final double maxDistance;
  final double distance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset(0, distance);
        return Positioned(
          right: 0,
          bottom: 4 + offset.dy,
          child: Transform.scale(
            scale: progress.value,
            child: Transform.rotate(
              angle: (1.0 - progress.value) * math.pi / 2,
              alignment: Alignment.bottomRight,
              child: child!,
            ),
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}
