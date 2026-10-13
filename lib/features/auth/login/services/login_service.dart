import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/storage/secured_storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/models/login_model.dart';

class LoginService {
  ApiClient apiClient;
  LoginService({required this.apiClient});

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.loginEndpoint,
      data: {'email': email, 'password': password},
    );
    final modelData = LoginModel.fromJson(response.data);
    await SecureStorage.saveAccessToken(modelData.accessToken);
    await SecureStorage.saveRefreshToken(modelData.refreshToken);
    return modelData;
  }
}
