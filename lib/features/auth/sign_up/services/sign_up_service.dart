import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/sign_up_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/sign_up_res_model.dart';

class SignUpService {
  ApiClient apiClient;
  SignUpService(this.apiClient);

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
