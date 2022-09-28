import 'package:flutter/cupertino.dart';
import 'package:flutter_base/values/colors.dart';

class DottedLineWidget extends StatelessWidget {
  final double height;
  final double width;
  final double heightContainer;
  final Color color;

  const DottedLineWidget(
      {this.height = 3,
      this.width = 1,
      this.color = Colors.black,
      this.heightContainer = 70});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightContainer,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxHeight = constraints.constrainHeight();
          final dashWidth = width;
          final dashHeight = height;
          final dashCount = (boxHeight / (2 * dashHeight)).floor();
          return Flex(
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.vertical,
          );
        },
      ),
    );
  }
}
