import 'package:padel/data/models/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_settings_model.g.dart';

@JsonSerializable()
class CompanySettingsModel {
  @JsonKey(name: '_id')
  String id;
  double matchPrice;

  CompanySettingsModel({required this.id, required this.matchPrice});
  factory CompanySettingsModel.fromJson(Map<String, dynamic> json) => _$CompanySettingsModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanySettingsModelToJson(this);

  @override
  String toString() {
    return 'ID: [$id], Match Price: [$matchPrice]';
  }
}