import 'package:access_control/src/models/guest_model.dart';
import 'package:access_control/utils/exceptions.dart';
import 'package:either_dart/either.dart';

abstract class IDatabaseGuestRepository {
  Future<Either<IPRException, List<GuestModel>>> getAllGuests();
  Future<Either<IPRException, bool>> removeGuest(GuestModel guest);
  Future<Either<IPRException, int>> insertGuest(GuestModel guest);
  Future<Either<IPRException, bool>> updateGuest(GuestModel guest);
  Future<Either<IPRException, bool>> clearDatabaseGuests();
}
