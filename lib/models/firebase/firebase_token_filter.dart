import 'package:json_annotation/json_annotation.dart';

part 'firebase_token_filter.g.dart';

@JsonSerializable()
class FirebaseTokenFilter {
  String? deviceToken; // Device token
  String? firebaseToken; // Firebase Token

  FirebaseTokenFilter({
    this.deviceToken,
    this.firebaseToken,
  });

  Map<String, dynamic> toJson() => _$FirebaseTokenFilterToJson(this);
}
