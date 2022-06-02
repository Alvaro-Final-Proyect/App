import '../../data/models/company_settings_model.dart';
import '../../data/network/api_service.dart';

class UpdateCompanyUseCase {
  final ApiService _api = ApiService();
  Future<CompanySettingsModel> call(CompanySettingsModel companySettingsModel) =>
      _api.updateCompanySettings(companySettingsModel);
}
