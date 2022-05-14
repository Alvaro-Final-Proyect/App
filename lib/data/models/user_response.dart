import 'package:json_annotation/json_annotation.dart';
part 'user_response.g.dart';
@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  String? id;
  String? username;
  String? email;
  String? name;
  String? surname;
  String? password;
  String? gender;
  String? position;
  double? level;
  List<String>? friends;
  List<String>? friendsRequests;

  UserModel({this.id, this.username, this.email, this.name, this.surname, this.password, this.gender, this.level, this.friends, this.friendsRequests, this.position});
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() => 'UserResponse{id: $id, username: $username, email: $email, level: $level}';
}