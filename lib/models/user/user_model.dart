import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  dynamic deviceId; // id
  String? name; // name
  String? avatar; // avatar
  String? accessToken; // Access token
  String? password; // Access token
  dynamic joinedAt;

  UserModel(
      {this.id,
      this.deviceId,
      this.name,
      this.password,
      this.avatar,
      this.joinedAt,
      this.accessToken});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
