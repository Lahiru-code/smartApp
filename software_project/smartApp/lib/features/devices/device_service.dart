import '../../core/network/api_client.dart';
import 'device_model.dart';

class DeviceService {
  DeviceService(this.api);
  final ApiClient api;

  static final List<DeviceModel> _fallbackDevices = [
    DeviceModel(
        id: 'main_lights', title: 'Main Lights', isOn: true, sliderValue: 82),
    DeviceModel(
        id: 'board_lights', title: 'Board Lights', isOn: true, sliderValue: 72),
    DeviceModel(id: 'projector', title: 'Projector', isOn: false),
    DeviceModel(id: 'hvac', title: 'HVAC', isOn: true, sliderValue: 24),
    DeviceModel(id: 'audio', title: 'Audio', isOn: false),
    DeviceModel(
        id: 'emergency_lights',
        title: 'Emergency Lights',
        isOn: true,
        sliderValue: 100),
  ];

  Future<List<DeviceModel>> fetchDevices() async {
    try {
      final res = await api.get('/api/devices'); // ✅ public
      final list = (res['devices'] as List?) ?? [];
      if (list.isEmpty) {
        return List<DeviceModel>.from(_fallbackDevices);
      }

      return list
          .map((e) => DeviceModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return List<DeviceModel>.from(_fallbackDevices);
    }
  }

  Future<void> updateDevice({
    required String id,
    required bool isOn,
    int? sliderValue,
  }) async {
    try {
      await api.patch('/api/devices/$id', {
        // ✅ public
        'isOn': isOn,
        'sliderValue': sliderValue,
      });
    } catch (_) {
      // Keep the UI responsive when the backend is not available.
    }
  }
}
