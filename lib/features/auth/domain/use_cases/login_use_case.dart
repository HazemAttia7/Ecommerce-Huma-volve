import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failure_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/auth_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repos/auth_repo.dart';

class LoginUseCase {
  final AuthRepo authRepo;

  LoginUseCase(this.authRepo);

  Future<Either<Failure, AuthEntity>> invoke({
    required String email,
    required String password,
  }) async =>
      await authRepo.login(email: email, password: password);
}
