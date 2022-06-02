import 'package:padel/data/models/company_settings_model.dart';
import 'package:padel/data/network/api_service.dart';

class GetCompanySettingsUseCase {
  final ApiService _api = ApiService();
  Future<CompanySettingsModel> call() => _api.getCompanySettings();
}