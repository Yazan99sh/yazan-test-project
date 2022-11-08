import 'package:flutter/material.dart';


class CardView extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;
  final double elevation;
  final BoxDecoration? decoration;
  final double borderRadius;

  const CardView({
    this.onTap,
    required this.child,
    Key? key,
    this.color,
    this.elevation = 2,
    this.decoration,

    this.borderRadius = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Material(
        elevation: elevation,
        color: color,
        clipBehavior:Clip.antiAliasWithSaveLayer ,
        borderRadius:  BorderRadius.all(Radius.circular(borderRadius)),
        child: InkWell(
          onTap: onTap != null
              ? () {
            onTap!();
          }
              : null,
          child: child,

        ),
      ),
    );
  }
}
