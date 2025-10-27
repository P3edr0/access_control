import 'package:access_control/src/models/guest_model.dart';
import 'package:access_control/utils/exceptions.dart';
import 'package:either_dart/either.dart';

abstract class IGetGuestRepository {
  Future<Either<IPRException, GuestModel>> getGuest();
}
