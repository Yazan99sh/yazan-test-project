import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalStatistics extends StatelessWidget {
  final IconData icon;
  final int numbers;
  final Color? color;
  const VerticalStatistics(
      {Key? key, required this.icon, required this.numbers, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 50.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Opacity(
                opacity: color == null ? 1 : 0,
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Visibility(
                visible: color == null,
                replacement: Icon(
                  icon,
                  color: Colors.white,
                ),
                child: Text(
                  NumberFormat.compact().format(numbers),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
