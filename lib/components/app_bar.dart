import 'package:access_control/components/buttons/animate_icon_button.dart';
import 'package:access_control/responsiveness/font_style.dart';
import 'package:access_control/theme/colors.dart';
import 'package:access_control/utils/constants/icons.dart';
import 'package:flutter/material.dart';

class AccAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccAppBar({super.key, required this.label});
  final String label;
  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + (kToolbarHeight / 2));
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      animateColor: false,
      backgroundColor: primaryColor,
      surfaceTintColor: primaryColor,
      shadowColor: black,
      centerTitle: true,
      leading: Navigator.canPop(context)
          ? Padding(
              padding: const EdgeInsets.only(top: 20),

              child: AccAnimatedIconButton(
                onTap: () {
                  if (!Navigator.canPop(context)) {
                    return;
                  }
                  Navigator.pop(context);
                },
                icon: AccIcons.back,
                iconColor: secondaryColor,
                onTapIconColor: darkBlue,
              ),
            )
          : null,

      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          label,
          style: AccFontStyle.h3Bold.copyWith(color: secondaryColor),
        ),
      ),
    );
  }
}
