// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchModel _$MatchModelFromJson(Map<String, dynamic> json) => MatchModel(
      id: json['_id'] as String,
      players: (json['players'] as List<dynamic>)
          .map((e) =>
              e == null ? null : UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      minLevel: (json['minLevel'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      maxLevel: (json['maxLevel'] as num).toDouble(),
      winner: json['winner'] as int?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
    );

Map<String, dynamic> _$MatchModelToJson(MatchModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'players': instance.players,
      'minLevel': instance.minLevel,
      'maxLevel': instance.maxLevel,
      'date': instance.date.toIso8601String(),
      'winner': instance.winner,
      'result': instance.result,
    };
