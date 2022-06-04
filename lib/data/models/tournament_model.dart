import 'package:json_annotation/json_annotation.dart';
import 'package:padel/data/models/user_response.dart';

import 'match_model.dart';

part 'tournament_model.g.dart';

@JsonSerializable()
class TournamentModel {
  @JsonKey(name: '_id')
  String id;
  List<MatchModel> roundOfSixteen;
  @JsonKey(name: 'quarterFinal')
  List<MatchModel> quarterFinals;
  List<MatchModel> semifinals;
  @JsonKey(name: 'final')
  MatchModel finalMatch;

  TournamentModel({
    this.id = '',
    required this.roundOfSixteen,
    required this.quarterFinals,
    required this.semifinals,
    required this.finalMatch,
  });

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentModelFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentModelToJson(this);

  @override
  String toString() {
    return 'TournamentModel{id: $id, roundOfSixteen: $roundOfSixteen, quarterFinals: $quarterFinals, semifinals: $semifinals, finalMatch: $finalMatch,}';
  }
}
