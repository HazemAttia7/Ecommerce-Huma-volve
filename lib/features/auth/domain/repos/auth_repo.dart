import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failure_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/auth_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  });
}
