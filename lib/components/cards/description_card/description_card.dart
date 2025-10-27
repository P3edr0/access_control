import 'package:access_control/components/cards/description_card/description_card_item.dart';
import 'package:access_control/responsiveness/font_style.dart';
import 'package:access_control/responsiveness/responsive.dart';
import 'package:access_control/theme/colors.dart';
import 'package:flutter/material.dart';

class AccDescriptionCard extends StatefulWidget {
  const AccDescriptionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
  }) : centralColor = darkBlue;
  const AccDescriptionCard.secondary({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    required this.centralColor,
  });

  final String title;
  final IconData icon;
  final List<AccDescriptionCardItem> items;
  final Color centralColor;

  @override
  State<AccDescriptionCard> createState() => _AccDescriptionCardState();
}

class _AccDescriptionCardState extends State<AccDescriptionCard> {
  bool showConfidentialInfo = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: Responsive.getSize(16)),

      decoration: BoxDecoration(
        boxShadow: lightShadow,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: primaryFocusColor,
      ),

      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.getSize(16),
              vertical: Responsive.getSize(10),
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: primaryColor,
                  size: Responsive.getSize(20),
                ),
                SizedBox(width: Responsive.getSize(10)),
                Text(
                  widget.title,
                  style: AccFontStyle.titleBold.copyWith(color: primaryColor),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.getSize(16),
              vertical: Responsive.getSize(16),
            ),
            decoration: BoxDecoration(
              boxShadow: mediumShadow,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: widget.centralColor,
            ),
            child: Column(children: widget.items),
          ),
        ],
      ),
    );
  }
}
