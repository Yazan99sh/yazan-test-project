import 'dart:ui';

import 'package:flutter/material.dart';

class TagChips extends StatelessWidget {
  final List<String> tags;
  final bool wrapped;
  const TagChips({Key? key, required this.tags, this.wrapped = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    tags.asMap().forEach((index, tag) {
      Widget chipTag = Padding(
        padding: const EdgeInsetsDirectional.only(end: 4),
        child: Chip(
          label: Text(
            tag,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      );
      children.add(chipTag);
    });
    if (wrapped) {
      return SingleChildScrollView(
        child: Wrap(
          children: children,
        ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: children,
      ),
    );
  }
}
