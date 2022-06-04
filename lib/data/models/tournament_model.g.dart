// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentModel _$TournamentModelFromJson(Map<String, dynamic> json) =>
    TournamentModel(
      id: json['_id'] as String? ?? '',
      roundOfSixteen: (json['roundOfSixteen'] as List<dynamic>)
          .map((e) => MatchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      quarterFinals: (json['quarterFinal'] as List<dynamic>)
          .map((e) => MatchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      semifinals: (json['semifinals'] as List<dynamic>)
          .map((e) => MatchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      finalMatch: MatchModel.fromJson(json['final'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TournamentModelToJson(TournamentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'roundOfSixteen': instance.roundOfSixteen,
      'quarterFinal': instance.quarterFinals,
      'semifinals': instance.semifinals,
      'final': instance.finalMatch,
    };
