import 'package:get/get.dart';
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
  String? image;
  double? level;
  List<String>? friends;
  List<String>? friendsRequests;
  List<String> matchesInvitations;
  bool isAdmin;

  UserModel({this.matchesInvitations = const [], this.id, this.username, this.email, this.name, this.surname, this.password, this.gender, this.level, this.friends, this.friendsRequests, this.position, this.image, this.isAdmin = false});
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() => 'UserResponse{id: $id, username: $username, email: $email, level: $level, friends: $friends, position: $position}';

  String get fullName => '${name?.capitalize} ${surname?.capitalize}';
}