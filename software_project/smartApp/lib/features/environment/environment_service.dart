import '../../core/network/api_client.dart';

class EnvironmentService {
  EnvironmentService(this.api);
  final ApiClient api;

  Future<Map<String, dynamic>> latest() => api.get('/api/environment/latest');
  Future<Map<String, dynamic>> history() => api.get('/api/environment/history');
}
