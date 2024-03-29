import 'dart:collection';

import 'package:padel/data/models/match_model.dart';
import 'package:padel/data/models/token_response.dart';
import 'package:padel/data/models/tournament_model.dart';
import 'package:padel/data/models/user_response.dart';
import 'package:padel/util/wrap_map.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/company_settings_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://padel-it.herokuapp.com/")
abstract class ApiClient{
  factory ApiClient(Dio dio) = _ApiClient;

  @POST('/login')
  Future<TokenModel> login(@Body() Map<String, String> userCredentials);

  @GET('/api/users/getUserFromToken')
  Future<UserModel> getUserFromToken();

  @POST('/register')
  Future<void> registerUser(@Body() UserModel newUser);

  @GET('/api/users')
  Future<List<UserModel>> getAllUsers();

  @PATCH('/api/users/sendFriendRequest/{id}')
  Future<void> sendFriendRequest(@Path() String id);

  @PATCH('/api/users/acceptFriendRequest/{id}')
  Future<UserModel> acceptFriendRequest(@Path() String id);

  @PATCH('/api/users/removeFriend/{id}')
  Future<UserModel> removeFriend(@Path() String id);

  @PATCH('/api/users/{id}')
  Future<void> saveUser(@Body() UserModel user, @Path() String id);

  @GET('/api/matches/')
  Future<List<MatchModel>> getAllMatches();

  @PATCH('/api/matches/joinToMatch/{id}&{index}')
  Future<MatchModel> joinToMatch(@Path() String id, @Path() int index);

  @PATCH('/api/matches/leaveMatch/{id}')
  Future<MatchModel> leaveMatch(@Path() String id);

  @POST('/api/matches/')
  Future<MatchModel> createMatch(@Body() MatchModel match);

  @GET('/api/users/getAllFriends')
  Future<List<UserModel>> getAllFriends();

  @PATCH('/api/users/sendMatchInvitation/{matchId}&{userInvitedId}')
  Future<void> sendMatchInvitation(@Path() String matchId, @Path() String userInvitedId);

  @GET('/api/users/getInvitedMatches')
  Future<List<MatchModel>> getInvitedMatches();

  @GET('/api/users/getUserMatches')
  Future<List<MatchModel>> getUserMatches();

  @PATCH('/api/matches/setMatchResult/{id}&{winner}')
  Future<void> setMatchResult(@Path() String id, @Path() int winner, @Body() Map<String, List<List<int>>> result);

  @GET('/api/matches/getLastWeekMatches')
  Future<List<MatchModel>> getLastWeekMatches();

  @GET('/api/companySettings/')
  Future<CompanySettingsModel> getCompanySettings();

  @PATCH('/api/companySettings/')
  Future<CompanySettingsModel> updateCompanySettings(@Body() CompanySettingsModel companySettingsModel);

  @GET('/getAllUsernamesAndEmails')
  Future<WrapMap> getAllUsernamesAndEmails();

  @POST('/api/users')
  Future<UserModel> createUser(@Body() UserModel userModel);

  @GET('/api/tournaments')
  Future<List<TournamentModel>> getAllTournaments();

  @POST('/api/tournaments')
  Future<TournamentModel> createTournamentModel(@Body() Map<String, dynamic> body);

  @PATCH('/api/matches/joinToMatchWithId/{id}&{index}&{userId}')
  Future<MatchModel> joinToMatchWithId(@Path() String id, @Path() int index, @Path() String userId);
}