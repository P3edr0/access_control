// ignore_for_file: must_be_immutable

import 'package:access_control/components/buttons/animate_icon_button.dart';
import 'package:access_control/components/icon_link_row.dart';
import 'package:access_control/responsiveness/font_style.dart';
import 'package:access_control/responsiveness/responsive.dart';
import 'package:access_control/src/models/coordinates_model.dart';
import 'package:access_control/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class AccGuestResumeCard extends StatefulWidget {
  AccGuestResumeCard({
    super.key,
    required this.city,
    required this.name,
    required this.image,
    required this.age,
    required this.email,
    required this.phone,
    required this.coordinatesModel,
    required this.onTap,

    this.backgroundColor = mediumGrey,
    required this.iconButtons,
  }) : isSelected = false,
       deleteMode = false,
       currentBackgroundColor = backgroundColor;
  AccGuestResumeCard.withSelector({
    super.key,
    required this.city,
    required this.name,
    required this.image,
    required this.age,
    required this.email,
    required this.phone,
    required this.coordinatesModel,
    required this.onTap,
    required this.iconButtons,

    required this.isSelected,
    required this.deleteMode,
    this.backgroundColor = mediumGrey,
  }) : currentBackgroundColor = backgroundColor;
  final String name;
  final bool deleteMode;
  final bool isSelected;
  final String city;
  final String image;
  final String email;
  final String phone;
  final CoordinatesModel coordinatesModel;
  final int age;
  Color backgroundColor;
  Color currentBackgroundColor;
  final void Function() onTap;
  List<AccAnimatedIconButton> iconButtons;

  @override
  State<AccGuestResumeCard> createState() => _AccGuestResumeCardState();
}

class _AccGuestResumeCardState extends State<AccGuestResumeCard> {
  void setOnTapColor(bool startTapped) {
    if (startTapped) {
      widget.currentBackgroundColor = secondaryColor;
    } else {
      widget.currentBackgroundColor = widget.backgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() => setOnTapColor(true));
        await Future.delayed(const Duration(milliseconds: 200));
        setState(() => setOnTapColor(false));

        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onTap();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isSelected && widget.deleteMode
              ? alertColor
              : primaryColor,
          boxShadow: defaultShadow,

          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: EdgeInsets.only(
          right: Responsive.getSize(6),
          bottom: Responsive.getSize(1),
          top: Responsive.getSize(1),
          left: Responsive.getSize(1),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: Responsive.getSize(16),
          vertical: Responsive.getSize(8),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: widget.currentBackgroundColor,

            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          padding: EdgeInsets.all(Responsive.getSize(10)),
          child: Row(
            children: [
              CircleAvatar(
                radius: Responsive.getSize(42),
                backgroundColor: widget.isSelected && widget.deleteMode
                    ? alertColor
                    : primaryColor,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.image),
                  radius: Responsive.getSize(40),
                ),
              ),
              SizedBox(width: Responsive.getSize(16)),

              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: AccFontStyle.titleBold.copyWith(
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      '${widget.age} anos, ${widget.city}',
                      style: AccFontStyle.bodyLarge,
                    ),
                    AccIconLinkRow(iconButtons: widget.iconButtons),
                  ],
                ),
              ),
              getIcon(),
            ],
          ),
        ),
      ),
    );
  }

  Icon getIcon() {
    if (!widget.deleteMode) {
      return Icon(
        FeatherIcons.chevronRight,
        size: Responsive.getSize(24),
        color: primaryFocusColor,
      );
    }

    if (widget.isSelected) {
      return Icon(
        FeatherIcons.xSquare,
        size: Responsive.getSize(24),
        color: alertColor,
      );
    }
    return Icon(
      FeatherIcons.square,
      size: Responsive.getSize(24),
      color: primaryFocusColor,
    );
  }
}
