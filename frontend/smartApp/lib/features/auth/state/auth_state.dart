class AuthState {
  final bool isAuthenticated;
  final String? token;

  const AuthState({required this.isAuthenticated, this.token});

  factory AuthState.unauthenticated() => const AuthState(isAuthenticated: false);
  factory AuthState.authenticated(String token) => AuthState(isAuthenticated: true, token: token);
}
