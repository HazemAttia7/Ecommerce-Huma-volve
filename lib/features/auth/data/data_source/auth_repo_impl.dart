import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/errors/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failure_model.dart';
import 'package:ecommerce_app_huma_volve/core/storage/secured_storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/sign_up_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/auth_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginModel = await remoteDataSource.login(
        email: email,
        password: password,
      );
      if (loginModel.accessToken.isNotEmpty) {
        await SecureStorage.saveAccessToken(loginModel.accessToken);
      }
      if (loginModel.refreshToken.isNotEmpty) {
        await SecureStorage.saveRefreshToken(loginModel.refreshToken);
      }
      return Right(loginModel);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final signUpReqModel = SignUpReqModel(
        name: name,
        email: email,
        password: password,
      );
      final userModel = await remoteDataSource.signUp(signUpReqModel);
      return Right(userModel);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }
}
