import 'package:access_control/src/models/guest_model.dart';
import 'package:access_control/src/repository/guest_repository/get_guest_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required this.getGuestRepository});
  final TextEditingController _filterController = TextEditingController();
  final IGetGuestRepository getGuestRepository;
  final List<GuestModel> _guestList = [];
  List<GuestModel> _filteredList = [];
  TextEditingController get filterController => _filterController;
  List<GuestModel> get filteredList => _filteredList;
  List<GuestModel> get guestList => _guestList;
  int get onQueueQuantity => filteredList.length;

  Future<void> getGuest() async {
    final response = await getGuestRepository.getGuest();
    response.fold((left) {}, (newGuest) {
      _guestList.insert(0, newGuest);
      _filteredList.insert(0, newGuest);
      if (filterController.text.isNotEmpty) {
        final filterContent = filterController.text;
        filterGuests(filterContent);
      } else {
        notifyListeners();
      }
    });
  }

  insertGuest(GuestModel newGuest) {
    _guestList.add(newGuest);
    _filteredList.add(newGuest);

    notifyListeners();
  }

  filterGuests(String content) {
    if (content.isEmpty) {
      _filteredList = [...guestList];
      notifyListeners();
      return;
    }
    final handledList = _guestList
        .where(
          (guest) => guest.name.toLowerCase().contains(content.toLowerCase()),
        )
        .toList();
    _filteredList = [...handledList];

    notifyListeners();
  }

  removeGuest(GuestModel newGuest) {
    _guestList.removeWhere(
      (element) => element.profile.uuid == newGuest.profile.uuid,
    );
    _filteredList.removeWhere(
      (element) => element.profile.uuid == newGuest.profile.uuid,
    );
    notifyListeners();
  }
}
