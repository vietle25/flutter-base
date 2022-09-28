import 'package:chopper/chopper.dart';
import 'package:flutter_base/repositories/api_client.dart';

part 'user_repository.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class UserRepository extends ApiClient {
  static UserRepository? manager;

  static UserRepository create() {
    final client = ApiClient.create();
    return _$UserRepository(client);
  }

  static UserRepository? getInstance() {
    if (manager == null) {
      manager = UserRepository.create();
      return manager;
    }
    return manager;
  }
}
