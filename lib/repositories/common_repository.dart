import 'package:chopper/chopper.dart';
import 'package:flutter_base/models/common/message_unread_filter.dart';
import 'package:flutter_base/models/response/api_response.dart';
import 'package:flutter_base/repositories/api_client.dart';

part 'common_repository.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class CommonRepository extends ApiClient {
  static CommonRepository? manager;

  static CommonRepository create() {
    final client = ApiClient.create();
    return _$CommonRepository(client);
  }

  static _$CommonRepository? getInstance() {
    if (manager == null) {
      manager = CommonRepository.create();
      return manager as _$CommonRepository?;
    }
    return manager as _$CommonRepository?;
  }
}
