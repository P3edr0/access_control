import 'package:access_control/components/buttons/animate_icon_button.dart';
import 'package:access_control/components/icon_link_row.dart';
import 'package:access_control/responsiveness/font_style.dart';
import 'package:access_control/responsiveness/responsive.dart';
import 'package:access_control/theme/colors.dart';
import 'package:access_control/utils/constants/icons.dart';
import 'package:flutter/material.dart';

class AccDetailProfileCard extends StatelessWidget {
  const AccDetailProfileCard({
    super.key,
    required this.picture,
    required this.isOnParty,
    required this.onTapAddOnParty,
    required this.onTapRemoveOnParty,
    required this.age,
    required this.iconButtons,
    required this.isMale,
    required this.name,
  });
  final bool isOnParty;
  final String picture;
  final Function() onTapAddOnParty;
  final Function() onTapRemoveOnParty;
  final bool isMale;
  final String name;
  final int age;
  final List<AccAnimatedIconButton> iconButtons;
  Widget getGenderIcon() {
    if (isMale) {
      return Icon(
        AccIcons.male,
        size: Responsive.getSize(24),
        color: mediumBlue,
      );
    }
    return Icon(AccIcons.female, size: Responsive.getSize(24), color: pink);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(Responsive.getSize(16)),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.getSize(16),
        vertical: Responsive.getSize(16),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: secondaryGradient,
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isOnParty
              ? AccAnimatedIconButton(
                  onTap: onTapRemoveOnParty,
                  icon: AccIcons.dislike,
                  iconColor: primaryFocusColor,
                  onTapIconColor: primaryColor,
                )
              : SizedBox(width: Responsive.getSize(22)),
          Column(
            children: [
              Text(
                isOnParty ? 'Está na festa..' : 'Não está na festa..',
                style: AccFontStyle.body.copyWith(color: secondaryColor),
              ),
              SizedBox(height: Responsive.getSize(6)),

              CircleAvatar(
                radius: Responsive.getSize(72),
                backgroundColor: transparent,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(picture),
                  radius: Responsive.getSize(72),
                ),
              ),
              SizedBox(height: Responsive.getSize(10)),
              Text(
                name,
                style: AccFontStyle.titleBold.copyWith(color: secondaryColor),
              ),
              Text(
                '$age anos',
                style: AccFontStyle.bodyLarge.copyWith(color: secondaryColor),
              ),
              SizedBox(height: Responsive.getSize(10)),
              getGenderIcon(),
              SizedBox(height: Responsive.getSize(10)),

              AccIconLinkRow(iconButtons: iconButtons),
            ],
          ),
          !isOnParty
              ? AccAnimatedIconButton(
                  onTap: onTapAddOnParty,

                  icon: AccIcons.like,
                  iconColor: primaryFocusColor,
                  onTapIconColor: primaryColor,
                )
              : SizedBox(width: Responsive.getSize(22)),
        ],
      ),
    );
  }
}
