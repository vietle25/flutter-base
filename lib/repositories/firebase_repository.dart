import 'package:chopper/chopper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_base/models/firebase/firebase_token_filter.dart';
import 'package:flutter_base/models/response/api_response.dart';
import 'package:flutter_base/repositories/api_client.dart';

abstract class FirebaseRepository extends ApiClient {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @Post(path: 'setFirebaseToken')
  Future<Response<ApiResponse>> setFirebaseToken(
      @Body() FirebaseTokenFilter body);
}
