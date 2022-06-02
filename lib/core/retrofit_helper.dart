import 'package:padel/data/models/company_settings_model.dart';
import 'package:padel/data/network/api_client.dart';
import 'package:dio/dio.dart';
import '../data/models/user_response.dart';

class RetrofitHelper {
  static final _dio = Dio();
  static ApiClient? _apiClient;
  static String _token = '';
  static UserModel? user;
  static late CompanySettingsModel companySettings;

  static ApiClient _initializeApiClient(){
    _dio.options.contentType = 'application/json';
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.headers['authorization'] = _token;
          handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          handler.next(response);
        },
        onError: (DioError error, ErrorInterceptorHandler handler){
          handler.next(error);
        }
      )
    );
    _apiClient = ApiClient(_dio);
    return _apiClient!;
  }

  static ApiClient getApiClient() {
    return _apiClient == null ? _initializeApiClient() : _apiClient!;
  }

  static setToken(String? token){
    _token = token?? '';
    _initializeApiClient();
  }

  static Interceptors getToken(){
    return _dio.interceptors;
  }
}
