import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final bool enabled;
  final double height;
  final double width;
  final double marginButton;
  final Widget? child;

  const ShimmerWidget(
      {Key? key,
      this.child,
      this.enabled = true,
      this.width = 55,
      this.height = 55,
      this.marginButton = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.btt,
      baseColor: Theme.of(context).cardColor,
      highlightColor: Colors.grey[300]!,
      enabled: enabled,
      loop: 5,
      child: child ??
          Container(
            height: height.toDouble(),
            width: width.toDouble(),
            margin: EdgeInsets.only(bottom: marginButton.toDouble()),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10.0)),
          ),
    );
  }
}
