// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanySettingsModel _$CompanySettingsModelFromJson(
        Map<String, dynamic> json) =>
    CompanySettingsModel(
      id: json['_id'] as String,
      matchPrice: (json['matchPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$CompanySettingsModelToJson(
        CompanySettingsModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'matchPrice': instance.matchPrice,
    };
