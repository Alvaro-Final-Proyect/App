import 'package:padel/data/models/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'match_model.g.dart';

@JsonSerializable()
class MatchModel implements Comparable<MatchModel> {
  @JsonKey(name: '_id')
  String id;
  List<UserModel?> players;
  double minLevel;
  double maxLevel;
  DateTime date;
  int? winner;
  List<List<int>>? result;
  bool isTournament;

  MatchModel({required this.id, required this.players, required this.minLevel, required this.date, required this.maxLevel, this.winner, this.result, this.isTournament = false});
  factory MatchModel.fromJson(Map<String, dynamic> json) => _$MatchModelFromJson(json);
  Map<String, dynamic> toJson() => _$MatchModelToJson(this);

  @override
  String toString() {
    return 'MatchModel{id: $id, players: $players, minLevel: $minLevel, date: ${date.millisecondsSinceEpoch}, isTournament: $isTournament';
  }

  @override
  int compareTo(MatchModel other) {
    if(date.millisecondsSinceEpoch > other.date.millisecondsSinceEpoch){
      return -1;
    }else if(date.millisecondsSinceEpoch < other.date.millisecondsSinceEpoch) {
      return 1;
    }
    return 0;
  }

  bool get isEmpty => players.any((element) => element == null);
  bool canJoin(UserModel user) => user.level! == user.level!.clamp(minLevel, maxLevel);
  String get winnerText => winner == null ? 'Unknown' : winner == 0 ? 'Team 1' : 'Team 2';
}