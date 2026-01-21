class DeviceModel {
  DeviceModel({
    required this.id,
    required this.title,
    required this.isOn,
    this.sliderValue,
  });

  final String id;
  final String title;
  bool isOn;
  int? sliderValue;

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['id'],
      title: json['title'],
      isOn: json['isOn'],
      sliderValue: json['sliderValue'],
    );
  }

  Map<String, dynamic> toJson() => {
        'isOn': isOn,
        'sliderValue': sliderValue,
      };
}
