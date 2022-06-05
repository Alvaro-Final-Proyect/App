import 'dart:collection';
import 'dart:developer';

import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/data/models/company_settings_model.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/data/models/token_response.dart';
import 'package:padel/data/models/tournament_model.dart';
import 'package:padel/data/models/user_response.dart';

import '../../util/wrap_map.dart';

class ApiService {
  ApiService._privateConstructor();
  static final ApiService api = ApiService._privateConstructor();
  factory ApiService() => api;

  Future<TokenModel> login(
    String username,
    String password
  ) async {

    final body = {
      'username':username,
      'password':password
    };

    final token = await RetrofitHelper.getApiClient().login(body);
    return token;
  }

  Future<UserModel> getUserFromToken() async {
    final user = await RetrofitHelper.getApiClient().getUserFromToken();
    return user;
  }

  Future<void> register(UserModel newUser) async {
      await RetrofitHelper.getApiClient().registerUser(newUser);
  }

  Future<void> logout() async {
    // TODO
  }

  Future<List<UserModel>> getAllUsers() async {
    final users = await RetrofitHelper.getApiClient().getAllUsers();
    return users;
  }

  Future<void> sendFriendRequest(String requestedId) async {
    await RetrofitHelper.getApiClient().sendFriendRequest(requestedId);
  }

  Future<void> saveUser(UserModel userModel) async{
    await RetrofitHelper.getApiClient().saveUser(userModel, userModel.id!);
  }

  Future<UserModel> acceptFriendRequest(String acceptedId) async {
    final userUpdated =  await RetrofitHelper.getApiClient().acceptFriendRequest(acceptedId);
    return userUpdated;
  }

  Future<UserModel> removeFriend(String friendId) async {
    final userUpdated = await RetrofitHelper.getApiClient().removeFriend(friendId);
    return userUpdated;
  }

  Future<List<MatchModel>> getAllMatches() async {
    final matches = await RetrofitHelper.getApiClient().getAllMatches();
    return matches;
  }

  Future<MatchModel> joinToMatch(String matchId, int index) async{
    final updatedMatch = await RetrofitHelper.getApiClient().joinToMatch(matchId, index);
    return updatedMatch;
  }

  Future<MatchModel> leaveMatch(String matchId) async {
    final updatedMatch = await RetrofitHelper.getApiClient().leaveMatch(matchId);
    return updatedMatch;
  }

  Future<MatchModel> createMatch(MatchModel match) async {
    final createdMatch = await RetrofitHelper.getApiClient().createMatch(match);
    return createdMatch;
  }

  Future<List<UserModel>> getAllFriends() async{
    final friends = await RetrofitHelper.getApiClient().getAllFriends();
    return friends;
  }

  Future<void> sendMatchInvitation(String matchId, String userInvitedId) async {
    await RetrofitHelper.getApiClient().sendMatchInvitation(matchId, userInvitedId);
  }

  Future<List<MatchModel>> getInvitedMatches() async {
    final matches = await RetrofitHelper.getApiClient().getInvitedMatches();
    return matches;
  }

  Future<List<MatchModel>> getUserMatches() async {
    final matches = await RetrofitHelper.getApiClient().getUserMatches();
    return matches;
  }

  Future<void> setMatchResult(String matchId, int winner, Map<String, List<List<int>>> result) async{
    await RetrofitHelper.getApiClient().setMatchResult(matchId, winner, result);
  }

  Future<List<MatchModel>> getLastWeekMatches() async {
    return await RetrofitHelper.getApiClient().getLastWeekMatches();
  }

  Future<CompanySettingsModel> getCompanySettings() async {
    return await RetrofitHelper.getApiClient().getCompanySettings();
  }

  Future<CompanySettingsModel> updateCompanySettings(CompanySettingsModel companySettingsModel) async {
    return await RetrofitHelper.getApiClient().updateCompanySettings(companySettingsModel);
  }

  Future<WrapMap> getAllUsernames() async {
    return await RetrofitHelper.getApiClient().getAllUsernamesAndEmails();
  }

  Future<UserModel> createUser(UserModel userModel) async {
    return await RetrofitHelper.getApiClient().createUser(userModel);
  }

  Future<List<TournamentModel>> getAllTournaments() async {
    return await RetrofitHelper.getApiClient().getAllTournaments();
  }

  Future<TournamentModel> createTournament(Map<String, dynamic> body) async {
    return await RetrofitHelper.getApiClient().createTournamentModel(body);
  }

  Future<MatchModel> joinToMatchWithId(String matchId, int index, String userId) async{
    final updatedMatch = await RetrofitHelper.getApiClient().joinToMatchWithId(matchId, index, userId);
    return updatedMatch;
  }
}