// ignore_for_file: must_be_immutable

import 'package:access_control/responsiveness/responsive.dart';
import 'package:flutter/material.dart';

class AccRectangleButton extends StatefulWidget {
  AccRectangleButton({
    super.key,
    required this.child,
    required this.onTap,
    required this.backgroundColor,
    this.onTapBackgroundColor,
    this.width = 150,
  }) : currentBackgroundColor = backgroundColor;
  final VoidCallback onTap;
  final Widget child;
  Color backgroundColor;
  Color? onTapBackgroundColor;
  Color currentBackgroundColor;
  final double width;

  @override
  State<AccRectangleButton> createState() => _AccRectangleButtonState();
}

class _AccRectangleButtonState extends State<AccRectangleButton> {
  void setOnTapColor(bool startTapped) {
    if (widget.onTapBackgroundColor == null) return;
    if (startTapped) {
      widget.currentBackgroundColor = widget.backgroundColor;
    } else {
      widget.currentBackgroundColor = widget.onTapBackgroundColor!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() => setOnTapColor(true));
        await Future.delayed(const Duration(milliseconds: 200));
        setState(() => setOnTapColor(false));
        widget.onTap();
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: Responsive.getSize(10)),
        height: Responsive.getSize(40),
        width: Responsive.getSize(widget.width),
        decoration: BoxDecoration(
          color: widget.currentBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: widget.child,
      ),
    );
  }
}
