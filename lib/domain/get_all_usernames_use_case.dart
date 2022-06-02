import 'package:padel/util/wrap_map.dart';
import '../data/network/api_service.dart';

class GetAllUsernamesAndEmailsUseCase {
  final ApiService _api = ApiService();
  Future<WrapMap> call() => _api.getAllUsernames();
}