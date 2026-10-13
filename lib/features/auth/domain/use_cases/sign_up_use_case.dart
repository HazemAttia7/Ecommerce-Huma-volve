import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failure_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repos/auth_repo.dart';

class SignUpUseCase {
  final AuthRepo authRepo;

  SignUpUseCase(this.authRepo);

  Future<Either<Failure, UserEntity>> invoke({
    required String name,
    required String email,
    required String password,
  }) async =>
      await authRepo.signUp(
        name: name,
        email: email,
        password: password,
      );
}
