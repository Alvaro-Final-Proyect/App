import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/data/models/match_model.dart';
import 'package:padel/data/models/token_response.dart';
import 'package:padel/data/models/user_response.dart';

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
}