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

  MatchModel({required this.id, required this.players, required this.minLevel, required this.date, required this.maxLevel, this.winner, this.result});
  factory MatchModel.fromJson(Map<String, dynamic> json) => _$MatchModelFromJson(json);
  Map<String, dynamic> toJson() => _$MatchModelToJson(this);

  @override
  String toString() {
    return 'MatchModel{id: $id, players: $players, minLevel: $minLevel, date: ${date.millisecondsSinceEpoch}';
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
}