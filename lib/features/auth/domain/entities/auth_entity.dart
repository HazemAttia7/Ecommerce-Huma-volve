class AuthEntity {
  final String accessToken;
  final String refreshToken;

  const AuthEntity({
    this.accessToken = '',
    this.refreshToken = '',
  });
}
