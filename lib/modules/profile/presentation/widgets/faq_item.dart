import 'package:flutter/material.dart';

class QAItem extends StatelessWidget {
  const QAItem({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final Widget title;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      initiallyExpanded: true,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: EdgeInsets.zero,
      title: title,
      collapsedIconColor: Colors.transparent,
      dense: false,
      collapsedShape: const RoundedRectangleBorder(),
      shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
      children: children,
    );
  }
}
