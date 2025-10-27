import 'package:access_control/responsiveness/font_style.dart';
import 'package:access_control/responsiveness/responsive.dart';
import 'package:access_control/theme/colors.dart';
import 'package:flutter/material.dart';

class AccDescriptionCardItem extends StatelessWidget {
  const AccDescriptionCardItem({
    super.key,
    required this.fieldTitle,
    required this.content,
    this.withDivider = true,
  }) : textColor = secondaryColor,
       dividerColor = mediumDarkBlue;
  const AccDescriptionCardItem.secondary({
    super.key,
    required this.fieldTitle,
    required this.content,
    required this.textColor,
    required this.dividerColor,
    this.withDivider = true,
  });

  final String fieldTitle;
  final String content;
  final bool withDivider;
  final Color textColor;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: Responsive.getSize(6)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  fieldTitle,
                  style: AccFontStyle.bodyLargeBold.copyWith(color: textColor),
                ),
              ),
              Expanded(
                child: Text(
                  content,
                  style: AccFontStyle.bodyLargeBold.copyWith(color: textColor),
                ),
              ),
            ],
          ),
        ),

        if (withDivider) Divider(height: 1, color: dividerColor),
      ],
    );
  }
}
