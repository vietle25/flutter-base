import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_base/values/colors.dart';

// ignore: must_be_immutable
class SwitchWidget extends StatefulWidget {
  bool? value; // Value
  final ValueChanged<bool?>? onChanged; // Value change
  final Color? activeColor; // Active color
  final Color inactiveColor; // In active color
  final String activeText; // Active text
  final String inactiveText; // In active text
  final Color activeTextColor; // Active text color
  final Color inactiveTextColor; // In active text color

  SwitchWidget(
      {Key? key,
      this.value,
      this.onChanged,
      this.activeColor,
      this.inactiveColor = Colors.greyLight,
      this.activeText = 'On',
      this.inactiveText = 'Off',
      this.activeTextColor = Colors.text,
      this.inactiveTextColor = Colors.text})
      : super(key: key);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;
  bool? value = false; // Value widget

  @override
  void initState() {
    super.initState();
    value = widget.value;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value! ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value! ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  void didUpdateWidget(covariant SwitchWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    value = widget.value;
    widget.value!
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            this.value = !this.value!;
            widget.onChanged!(this.value);
          },
          child: Container(
            width: 58.0,
            height: 24.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: _circleAnimation.value == Alignment.centerLeft
                  ? widget.inactiveColor
                  : widget.activeColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 0.0, left: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleAnimation.value == Alignment.centerRight
                      ? Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 4.0),
                          child: Text(
                            widget.activeText,
                            style: TextStyle(
                                color: widget.activeTextColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 16.0),
                          ),
                        )
                      : Container(),
                  Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.primary),
                    ),
                  ),
                  _circleAnimation.value == Alignment.centerLeft
                      ? Padding(
                          padding: EdgeInsets.only(left: 4.0, right: 8.0),
                          child: Text(
                            widget.inactiveText,
                            style: TextStyle(
                                color: widget.inactiveTextColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 16.0),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
