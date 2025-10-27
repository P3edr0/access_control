import 'package:access_control/src/models/guest_model.dart';
import 'package:flutter/material.dart';

class DetailsViewModel extends ChangeNotifier {
  DetailsViewModel();

  bool _isInside = false;

  GuestModel? _selectedGuest;

  bool get isOnParty => _isInside;
  GuestModel? get selectedGuest => _selectedGuest;

  setSelectedGuest(GuestModel newGuest) {
    _selectedGuest = newGuest;
    notifyListeners();
  }

  setGuestIsOnParty(bool newIsInside) {
    _isInside = newIsInside;
    notifyListeners();
  }
}
