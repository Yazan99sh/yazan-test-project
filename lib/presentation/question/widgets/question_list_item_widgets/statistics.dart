import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  final IconData icon;
  final int numbers;
  const Statistics({Key? key, required this.icon, required this.numbers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 15,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              NumberFormat.compact().format(numbers),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }
}
