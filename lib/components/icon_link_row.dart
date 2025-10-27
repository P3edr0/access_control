import 'package:access_control/components/buttons/animate_icon_button.dart';
import 'package:access_control/responsiveness/responsive.dart';
import 'package:flutter/material.dart';

class AccIconLinkRow extends StatelessWidget {
  const AccIconLinkRow({super.key, required this.iconButtons});
  final List<AccAnimatedIconButton> iconButtons;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: iconButtons
          .map(
            (icon) => Padding(
              padding: EdgeInsets.only(right: Responsive.getSize(16)),
              child: icon,
            ),
          )
          .toList(),
    );
  }
}
