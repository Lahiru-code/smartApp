import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';

class ApiClient {
  ApiClient(this._storage) {
    _dio = Dio(
      BaseOptions(
        // Use dart-define to override in run: --dart-define=API_BASE_URL=http://localhost:3000
        baseUrl: const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'http://localhost:3000',
        ),
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        contentType: 'application/json',
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.readToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  late final Dio _dio;
  final SecureStorage _storage;

  Dio get dio => _dio;

  // Auth APIs
  Future<String> login({required String email, required String password}) async {
    final res = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    final data = res.data as Map<String, dynamic>;
    final token = data['access_token'] as String?;
    if (token == null || token.isEmpty) {
      throw DioException(
        requestOptions: res.requestOptions,
        response: res,
        message: 'Missing access_token in response',
      );
    }
    return token;
  }

  Future<String> register({required String email, required String password}) async {
    final res = await _dio.post('/auth/register', data: {
      'email': email,
      'password': password,
    });
    final data = res.data as Map<String, dynamic>;
    final token = data['access_token'] as String?;
    if (token == null || token.isEmpty) {
      throw DioException(
        requestOptions: res.requestOptions,
        response: res,
        message: 'Missing access_token in response',
      );
    }
    return token;
  }
}
