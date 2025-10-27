// ignore_for_file: must_be_immutable

import 'package:access_control/responsiveness/responsive.dart';
import 'package:access_control/theme/colors.dart';
import 'package:flutter/material.dart';

class AccCircleAvatar extends StatefulWidget {
  AccCircleAvatar({
    super.key,
    required this.backgroundColor,
    required this.picture,
    required this.size,
    required this.onTap,
  }) : currentBackgroundColor = backgroundColor;
  final String picture;
  Color backgroundColor;
  Color currentBackgroundColor;
  final double size;
  final Function() onTap;

  @override
  State<AccCircleAvatar> createState() => _AccCircleAvatarState();
}

class _AccCircleAvatarState extends State<AccCircleAvatar> {
  void setOnTapColor(bool startTapped) {
    if (startTapped) {
      widget.currentBackgroundColor = widget.backgroundColor;
    } else {
      widget.currentBackgroundColor = primaryFocusColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() => setOnTapColor(true));
        await Future.delayed(const Duration(milliseconds: 200));
        setState(() => setOnTapColor(false));
        await Future.delayed(const Duration(milliseconds: 200));

        widget.onTap();
      },
      child: CircleAvatar(
        radius: Responsive.getSize(widget.size),
        backgroundColor: widget.currentBackgroundColor,
        child: CircleAvatar(
          backgroundImage: NetworkImage(widget.picture),
          radius: Responsive.getSize(widget.size - 2),
        ),
      ),
    );
  }
}
