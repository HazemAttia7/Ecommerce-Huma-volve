import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/sign_up_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/sign_up_res_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login({
    required String email,
    required String password,
  });

  Future<SignUpResModel> signUp(SignUpReqModel signUpReqModel);
}
