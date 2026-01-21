/*import '../../core/network/api_client.dart';

class AuthService {
  AuthService(this.api);
  final ApiClient api;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final res = await api.post('/api/auth/login', {
      'email': email,
      'password': password,
    });

    final token = res['token'] as String?;
    if (token == null || token.isEmpty) {
      throw Exception('Token not received from server');
    }
    await api.saveToken(token);
  }
}*/
import '../../core/network/api_client.dart';

class AuthService {
  AuthService(this.api);
  final ApiClient api;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    // 🔵 STEP 1: Confirm login function is called
    print('🔐 AuthService.login() CALLED');
    print('📤 Sending login request with email: $email');

    // 🔵 STEP 2: Send request to backend
    final res = await api.post(
      '/api/auth/login',
      {
        'email': email,
        'password': password,
      },
    );

    // 🔵 STEP 3: Confirm backend response arrived
    print('📥 Login response received from backend');
    print('📦 Full response: $res');

    final token = res['token'] as String?;

    // 🔵 STEP 4: Validate token
    if (token == null || token.isEmpty) {
      print('❌ ERROR: Token missing in response');
      throw Exception('Token not received from server');
    }

    print('✅ Token received successfully');
    print('🪪 JWT Token: $token');

    // 🔵 STEP 5: Save token
    await api.saveToken(token);
    print('💾 Token saved successfully');

    // 🔵 FINAL CONFIRMATION
    print('🎉 LOGIN FLOW COMPLETED SUCCESSFULLY');
  }
}

