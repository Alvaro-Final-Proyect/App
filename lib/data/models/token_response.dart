import 'package:json_annotation/json_annotation.dart';
part 'token_response.g.dart';
@JsonSerializable()
class TokenModel {
  String? token;
  String? message;

  TokenModel({this.token, this.message});
  factory TokenModel.fromJson(Map<String, dynamic> json) => _$TokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}