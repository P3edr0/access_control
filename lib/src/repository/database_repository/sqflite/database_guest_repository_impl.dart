import 'dart:developer';

import 'package:access_control/src/models/guest_model.dart';
import 'package:access_control/src/repository/database_repository/get_database_guest_repository.dart';
import 'package:access_control/src/repository/database_repository/sqflite/sqflite_database.dart';
import 'package:access_control/utils/exceptions.dart';
import 'package:either_dart/either.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabaseGuestRepositoryImpl implements IDatabaseGuestRepository {
  Future<Database> get _database async => await SqfliteDatabase().database;
  @override
  Future<Either<IPRException, List<GuestModel>>> getAllGuests() async {
    final database = await _database;
    final response = await database.query('guests', orderBy: 'id DESC');
    final allGuests = response.map((item) => GuestModel.fromMap(item)).toList();

    return Right(allGuests);
  }

  @override
  Future<Either<IPRException, int>> insertGuest(GuestModel guest) async {
    try {
      final database = await _database;
      final handledGuest = guest.toMap();
      final response = await database.query('guests', orderBy: 'id DESC');
      final allGuests = response
          .map((item) => GuestModel.fromMap(item))
          .toList();
      final haveGuest = allGuests.any(
        (item) => item.profile.uuid == guest.profile.uuid,
      );

      if (haveGuest) {
        return (Left(
          DuplicatePRException(message: 'o convidado já está na festa.'),
        ));
      }
      final int newId = await database.insert(
        'guests',
        handledGuest,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return Right(newId);
    } catch (e, stack) {
      log(stack.toString());
      return (Left(
        BadRequestPRException(message: 'Falha ao inserir convidado na festa.'),
      ));
    }
  }

  @override
  Future<Either<IPRException, bool>> removeGuest(GuestModel guest) async {
    final database = await _database;
    try {
      await database.delete('guests', where: 'id = ?', whereArgs: [guest.id]);
      return Right(true);
    } catch (e, stack) {
      log(stack.toString());

      return (Left(
        BadRequestPRException(message: 'Falha ao remover convidado da festa.'),
      ));
    }
  }

  @override
  Future<Either<IPRException, bool>> clearDatabaseGuests() async {
    try {
      final database = await _database;

      await database.delete('guests');
      return Right(true);
    } catch (e, stack) {
      log(stack.toString());

      return (Left(
        BadRequestPRException(
          message: 'Falha ao remover todos os convidado da festa.',
        ),
      ));
    }
  }

  @override
  Future<Either<IPRException, bool>> updateGuest(GuestModel guest) {
    // TODO: implement updateGuest
    throw UnimplementedError();
  }
}
