import 'package:access_control/src/models/guest_model.dart';
import 'package:access_control/src/repository/database_repository/get_database_guest_repository.dart';
import 'package:access_control/src/repository/guest_repository/get_guest_repository.dart';
import 'package:access_control/utils/exceptions.dart';
import 'package:flutter/material.dart';

class PartyViewModel extends ChangeNotifier {
  PartyViewModel({
    required this.getGuestRepository,
    required this.databaseGuestRepository,
  });
  final IGetGuestRepository getGuestRepository;
  final IDatabaseGuestRepository databaseGuestRepository;
  IPRException? _exception;
  bool _isDeleteMode = false;
  List<GuestModel> _onPartyList = [];
  List<GuestModel> _filteredList = [];
  final List<GuestModel> _toDeleteList = [];

  bool get isDeleteMode => _isDeleteMode;
  List<GuestModel> get onPartyList => _onPartyList;
  List<GuestModel> get onPartyFilteredList => _filteredList;
  List<GuestModel> get toDeleteList => _toDeleteList;
  int get onPartyQuantity => _onPartyList.length;
  int get onFilteredPartyQuantity => _filteredList.length;
  int get _toDeleteListQuantity => _toDeleteList.length;
  int get currentModeListSize =>
      isDeleteMode ? _toDeleteListQuantity : onPartyQuantity;
  bool get canDelete => _toDeleteList.isNotEmpty;
  bool get hasError => (_exception != null);
  IPRException get exception => _exception!;

  Future<void> getAllGuests() async {
    final dataResponse = await databaseGuestRepository.getAllGuests();
    dataResponse.fold(
      (newException) {
        _exception = newException;
      },
      (newGuests) {
        if (hasError) _exception = null;
        _onPartyList = [...newGuests];
        _filteredList = [...newGuests];
        notifyListeners();
      },
    );
  }

  setIsDeleteMode() async {
    _isDeleteMode = !_isDeleteMode;
    notifyListeners();
  }

  Future<int?> addGuestOnParty(GuestModel guest) async {
    onPartyList.insert(0, guest);
    onPartyFilteredList.insert(0, guest);
    notifyListeners();
    final dataResponse = await databaseGuestRepository.insertGuest(guest);
    return dataResponse.fold(
      (newException) {
        _exception = newException;
        onPartyList.removeAt(0);
        _filteredList = [...onPartyList];
        notifyListeners();
        return null;
      },
      (newId) {
        if (hasError) _exception = null;
        if (guest.id == null) {
          final handledGuest = guest.copyWith(id: newId);
          onPartyList.first = handledGuest;
          _filteredList = [...onPartyList];

          notifyListeners();
        }
        return newId;
      },
    );
  }

  Future<void> removeGuestOnParty(GuestModel guest) async {
    final guestIndex = onPartyList.indexWhere(
      (element) => element.profile.uuid == guest.profile.uuid,
    );
    onPartyList.removeWhere(
      (element) => element.profile.uuid == guest.profile.uuid,
    );
    toDeleteList.removeWhere(
      (element) => element.profile.uuid == guest.profile.uuid,
    );
    _filteredList = [...onPartyList];

    notifyListeners();
    final dataResponse = await databaseGuestRepository.removeGuest(guest);
    dataResponse.fold(
      (newException) {
        _exception = newException;
        onPartyList.insert(guestIndex, guest);
        toDeleteList.add(guest);
        _filteredList = [...onPartyList];

        notifyListeners();
      },
      (right) {
        if (hasError) _exception = null;
        notifyListeners();
      },
    );
  }

  addToDelete(GuestModel guest) {
    final isSelected = checkIsSelectedToDelete(guest);
    if (isSelected) {
      _toDeleteList.removeWhere(
        (oldGuest) => oldGuest.profile.uuid == guest.profile.uuid,
      );
      notifyListeners();

      return;
    }
    _toDeleteList.insert(0, guest);
    notifyListeners();
  }

  removeToDelete(GuestModel guest) {
    _toDeleteList.removeWhere(
      (element) => element.profile.uuid == guest.profile.uuid,
    );

    notifyListeners();
  }

  Future<void> deleteMultipleGuests() async {
    for (var tempGuest in toDeleteList) {
      onPartyList.removeWhere(
        (element) => element.profile.uuid == tempGuest.profile.uuid,
      );

      _filteredList = [...onPartyList];

      notifyListeners();
    }
    final calls = toDeleteList
        .map((element) => databaseGuestRepository.removeGuest(element))
        .toList();

    final responses = await Future.wait(calls);

    for (var response in responses) {
      response.fold((newException) {
        _exception = newException;
      }, (right) {});
    }

    if (!hasError) {
      _toDeleteList.clear();
      notifyListeners();
    } else {
      _exception = null;
      final recoveryCalls = toDeleteList
          .map((element) => databaseGuestRepository.insertGuest(element))
          .toList();

      final recoveryResponses = await Future.wait(recoveryCalls);

      for (var recoveryResponse in recoveryResponses) {
        recoveryResponse.fold((recoveryException) {
          if (recoveryException is DuplicatePRException) {
          } else {
            _exception = recoveryException;
          }
        }, (right) {});
      }
      if (hasError) {
        _onPartyList.addAll(_toDeleteList);

        _filteredList = [...onPartyList];

        _toDeleteList.clear();
        notifyListeners();
      } else {
        _toDeleteList.clear();
        notifyListeners();
      }
    }
  }

  bool checkIsOnParty(GuestModel guest) {
    final hasOnParty = onPartyList.where(
      (element) => element.profile.uuid == guest.profile.uuid,
    );
    if (hasOnParty.isEmpty) {
      return false;
    }
    return true;
  }

  bool checkIsSelectedToDelete(GuestModel guest) {
    final hasToDelete = toDeleteList.any(
      (element) => element.profile.uuid == guest.profile.uuid,
    );
    if (hasToDelete) {
      return true;
    }
    return false;
  }

  filterGuests(String content) {
    if (content.isEmpty) {
      _filteredList = [...onPartyList];
      notifyListeners();
      return;
    }
    final handledList = _onPartyList
        .where(
          (guest) => guest.name.toLowerCase().contains(content.toLowerCase()),
        )
        .toList();
    _filteredList = [...handledList];

    notifyListeners();
  }
}
