import 'package:access_control/src/views/details_page.dart';
import 'package:access_control/src/views/home_page.dart';
import 'package:access_control/src/views/party_page.dart';
import 'package:flutter/material.dart';

class PRNavigation {
  static void goToDetailsPage(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage()),
    );
  }

  static void goToPartyPage(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PartyPage()),
    );
  }

  static void goToHomePage(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  static void goToHardHomePage(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
