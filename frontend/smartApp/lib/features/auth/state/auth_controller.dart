/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/secure_storage.dart';
import 'auth_state.dart';

final secureStorageProvider = Provider((_) => SecureStorage());

final authControllerProvider = AsyncNotifierProvider<AuthController, AuthState>(AuthController.new);

class AuthController extends AsyncNotifier<AuthState> {
  late final SecureStorage _storage;

  @override
  Future<AuthState> build() async {
    _storage = ref.read(secureStorageProvider);
    final token = await _storage.readToken();
    if (token != null && token.isNotEmpty) {
      return AuthState.authenticated(token);
    }
    return AuthState.unauthenticated();
  }

  Future<void> loginSuccess(String token) async {
    state = const AsyncLoading();
    await _storage.writeToken(token);
    state = AsyncData(AuthState.authenticated(token));
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    await _storage.clearToken();
    state = AsyncData(AuthState.unauthenticated());
  }
}
*/