import 'package:access_control/components/buttons/rectangle_button.dart';
import 'package:access_control/responsiveness/font_style.dart';
import 'package:access_control/theme/colors.dart';
import 'package:flutter/material.dart';

class AccExceptionDialog {
  const AccExceptionDialog();

  static Future show(String title, String content, BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: AccFontStyle.titleBold.copyWith(color: alertColor),
        ),
        content: Text(content, textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          AccRectangleButton(
            backgroundColor: primaryFocusColor,
            onTap: () => Navigator.of(context).pop(),
            child: Text(
              "Fechar",
              textAlign: TextAlign.center,
              style: AccFontStyle.titleBold.copyWith(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
