import 'package:chopper/chopper.dart';
import 'package:flutter_base/configs/server.dart';
import 'package:flutter_base/models/response/error_converter.dart';
import 'package:flutter_base/models/response/model_converter.dart';
import 'package:flutter_base/repositories/header_interceptor.dart';

part 'api_client.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class ApiClient extends ChopperService {

  /// Create chopper client
  static ChopperClient create() {
    final client = ChopperClient(
        baseUrl: Server.apiUrl,
        services: [
          _$ApiClient(),
        ],
        converter: ModelConverter(),
        errorConverter: JsonErrorConverter(),
        interceptors: [
          HeaderInterceptor(),
          CurlInterceptor(),
          HttpLoggingInterceptor()
        ]);
    return client;
  }
}
