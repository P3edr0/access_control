// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AccAnimatedIconButton extends StatefulWidget {
  AccAnimatedIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.iconColor,
    this.onTapIconColor,
  }) : currentIconColor = iconColor;
  final Function() onTap;
  final IconData icon;
  final Color iconColor;
  final Color? onTapIconColor;
  Color currentIconColor;

  @override
  State<AccAnimatedIconButton> createState() => _AccAnimatedIconButtonState();
}

class _AccAnimatedIconButtonState extends State<AccAnimatedIconButton> {
  void setOnTapColor(bool startTapped) {
    if (widget.onTapIconColor == null) return;

    if (startTapped) {
      widget.currentIconColor = widget.onTapIconColor!;
    } else {
      widget.currentIconColor = widget.iconColor;
    }
  }

  double _shakeOffset = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setOnTapColor(true);
        setState(() => _shakeOffset = 2.0);
        await Future.delayed(const Duration(milliseconds: 100));
        setState(() => _shakeOffset = -2.0);
        await Future.delayed(const Duration(milliseconds: 100));
        setOnTapColor(false);
        setState(() => _shakeOffset = 0.0);

        widget.onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..translateByDouble(_shakeOffset, 1, 1, 1),
        child: Icon(widget.icon, color: widget.currentIconColor),
      ),
    );
  }
}
