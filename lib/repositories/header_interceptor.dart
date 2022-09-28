import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter_base/values/globals.dart';

class HeaderInterceptor implements RequestInterceptor {
  static final String contentType = "application/json; charset=UTF-8";
  static final String accept = "*/* ";
  static final String authorization =
      'Basic a2luZGVyd29ybGQtc3RhZ2luZy1tb2JpbGUtYXBpOk85MTk5N1FjQTF3eTZqOVI=';
  // static final String sessionId = 'ec53ab1fde33c12d859dc5b6b19bacf20726d80f';

  @override
  FutureOr<Request> onRequest(Request request) async {
    Map<String, String> headers = Map<String, String>();
    headers.addAll({"Content-Type": contentType});
    headers.addAll({"Accept": accept});
    headers.addAll({"Authorization": authorization});
    headers.addAll({"API-KEY": Globals.accessTokenAPI});
    headers.addAll({"X-Openerp-Session-Id": Globals.accessTokenAPI});
    Request newRequest = request.copyWith(headers: headers);
    return newRequest;
  }
}
