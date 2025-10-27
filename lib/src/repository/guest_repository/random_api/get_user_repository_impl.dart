import 'package:access_control/shared/framework/environment.dart';
import 'package:access_control/shared/services/http_client/http_client.dart';
import 'package:access_control/src/models/dtos/guest_dto.dart';
import 'package:access_control/src/models/guest_model.dart';
import 'package:access_control/src/repository/guest_repository/get_guest_repository.dart';
import 'package:access_control/utils/constants/constants.dart';
import 'package:access_control/utils/exceptions.dart';
import 'package:either_dart/either.dart';

class GetUserRandomApiRepositoryImpl implements IGetGuestRepository {
  GetUserRandomApiRepositoryImpl({required this.service});
  IHttpClient service;
  @override
  Future<Either<IPRException, GuestModel>> getGuest() async {
    final api = PREnvironment.apiUrl;
    final response = await service.get(api);

    if (response.statusCode == success) {
      final user = GuestDto.fromJson(response.data['results'][0]);
      return Right(user.toEntity());
    } else {
      return Left(
        BadRequestPRException(message: "Falha ao buscar dados do usuário."),
      );
    }
  }
}
