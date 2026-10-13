import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/sign_up_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/sign_up_res_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.loginEndpoint,
      data: {'email': email, 'password': password},
    );
    return LoginModel.fromJson(response.data);
  }

  @override
  Future<SignUpResModel> signUp(SignUpReqModel signUpReqModel) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.signUpEndpoint,
      data: {
        'name': signUpReqModel.name,
        'email': signUpReqModel.email,
        'password': signUpReqModel.password,
        'avatar': 'https://picsum.photos/800',
      },
    );
    return SignUpResModel.fromJson(response.data);
  }
}
