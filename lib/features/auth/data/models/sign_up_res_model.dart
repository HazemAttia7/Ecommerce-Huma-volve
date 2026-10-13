import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/user_entity.dart';

class SignUpResModel extends UserEntity {
  final String password;
  final String creationAt;
  final String updatedAt;

  SignUpResModel({
    super.id,
    super.email,
    super.name,
    super.role,
    super.avatar,
    this.password = '',
    this.creationAt = '',
    this.updatedAt = '',
  });

  factory SignUpResModel.fromJson(Map<String, dynamic> json) {
    return SignUpResModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      creationAt: json['creationAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }
}
