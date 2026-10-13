import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/auth_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/user_entity.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class LoginLoading extends AuthStates {}

class LoginSuccess extends AuthStates {
  final AuthEntity authEntity;

  LoginSuccess(this.authEntity);
}

class LoginError extends AuthStates {
  final String errorMessage;

  LoginError(this.errorMessage);
}

class SignUpLoading extends AuthStates {}

class SignUpSuccess extends AuthStates {
  final UserEntity userEntity;

  SignUpSuccess(this.userEntity);
}

class SignUpError extends AuthStates {
  final String errorMessage;

  SignUpError(this.errorMessage);
}
