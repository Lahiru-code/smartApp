import 'package:flutter/material.dart';
import 'app_shell.dart';

class DeviceControlScreen extends StatefulWidget {
  const DeviceControlScreen({super.key});

  @override
  State<DeviceControlScreen> createState() => _DeviceControlScreenState();
}

class _DeviceControlScreenState extends State<DeviceControlScreen> {
  bool _wide(BuildContext c) => MediaQuery.of(c).size.width >= 980;
  bool _mid(BuildContext c) => MediaQuery.of(c).size.width >= 680;

  final List<_DeviceModel> _devices = [
    _DeviceModel(
      id: 'main_lights',
      title: 'Main\nLights',
      subtitle: 'light',
      icon: Icons.lightbulb_outline,
      isOn: true,
      hasSlider: true,
      sliderLabel: 'Brightness',
      sliderUnit: '%',
      sliderValue: 80,
      powerWhenOn: 120,
    ),
    _DeviceModel(
      id: 'board_lights',
      title: 'Board\nLights',
      subtitle: 'light',
      icon: Icons.lightbulb_outline,
      isOn: true,
      hasSlider: true,
      sliderLabel: 'Brightness',
      sliderUnit: '%',
      sliderValue: 100,
      powerWhenOn: 60,
    ),
    _DeviceModel(
      id: 'projector',
      title: 'Projector',
      subtitle: 'projector',
      icon: Icons.tv_outlined,
      isOn: false,
      hasSlider: false,
      powerWhenOn: 0,
    ),
    _DeviceModel(
      id: 'hvac',
      title: 'HVAC\nSystem',
      subtitle: 'hvac',
      icon: Icons.air_outlined,
      isOn: true,
      hasSlider: true,
      sliderLabel: 'Temperature',
      sliderUnit: '°C',
      sliderValue: 22,
      sliderMin: 16,
      sliderMax: 30,
      powerWhenOn: 1500,
    ),
    _DeviceModel(
      id: 'audio',
      title: 'Audio\nSystem',
      subtitle: 'audio',
      icon: Icons.volume_up_outlined,
      isOn: false,
      hasSlider: false,
      powerWhenOn: 0,
    ),
    _DeviceModel(
      id: 'emergency_lights',
      title: 'Emergency\nLights',
      subtitle: 'light',
      icon: Icons.lightbulb_outline,
      isOn: true,
      hasSlider: true,
      sliderLabel: 'Brightness',
      sliderUnit: '%',
      sliderValue: 50,
      powerWhenOn: 40,
    ),
  ];

  int get _activeCount => _devices.where((d) => d.isOn).length;

  int get _totalPowerW =>
      _devices.where((d) => d.isOn).fold<int>(0, (sum, d) => sum + d.powerWhenOn);

  double get _estimatedCostPerHour {
    // Example tariff: $0.00012 per Wh (adjust later)
    return _totalPowerW * 0.00012;
  }

  void _turnAll(bool on) {
    setState(() {
      for (final d in _devices) {
        d.isOn = on;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cols = _wide(context) ? 3 : (_mid(context) ? 2 : 1);

    return AppShell(
      title: 'Device Control Center',
      subtitle: 'Manage and monitor all classroom devices',
      selectedRoute: '/device-control',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Grid(
            columns: _wide(context) ? 3 : (_mid(context) ? 2 : 1),
            children: [
              _SummaryCard(title: 'Total Power', value: '$_totalPowerW W'),
              _SummaryCard(title: 'Active Devices', value: '$_activeCount/${_devices.length}'),
              _SummaryCard(
                title: 'Estimated Cost',
                value: '\$${_estimatedCostPerHour.toStringAsFixed(2)} /hr',
              ),
            ],
          ),
          const SizedBox(height: 14),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _ActionButton(
                label: 'Turn All On',
                color: const Color(0xFF16A34A),
                onTap: () => _turnAll(true),
              ),
              _ActionButton(
                label: 'Turn All Off',
                color: const Color(0xFFDC2626),
                onTap: () => _turnAll(false),
              ),
              _ActionButton(
                label: 'Schedule Automation',
                color: const Color(0xFF2D66F6),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Schedule automation (TODO)')),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 14),

          _Grid(
            columns: cols,
            children: _devices
                .map(
                  (d) => _DeviceCard(
                    device: d,
                    onToggle: () => setState(() => d.isOn = !d.isOn),
                    onSlider: (v) => setState(() => d.sliderValue = v.round()),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

/* ---------------- widgets ---------------- */

class _Grid extends StatelessWidget {
  const _Grid({required this.columns, required this.children});
  final int columns;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, c) {
      final spacing = 14.0;
      final w = c.maxWidth;
      final itemW = (w - (columns - 1) * spacing) / columns;

      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: children.map((e) => SizedBox(width: itemW, child: e)).toList(),
      );
    });
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            blurRadius: 22,
            offset: const Offset(0, 14),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.60),
                  fontWeight: FontWeight.w800)),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A))),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
        ),
        child: Text(label),
      ),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({
    required this.device,
    required this.onToggle,
    required this.onSlider,
  });

  final _DeviceModel device;
  final VoidCallback onToggle;
  final ValueChanged<double> onSlider;

  @override
  Widget build(BuildContext context) {
    final accent = const Color(0xFF2D66F6);
    final hasSlider = device.hasSlider;

    return Container(
      height: hasSlider ? 220 : 175,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            blurRadius: 22,
            offset: const Offset(0, 14),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _IconTile(icon: device.icon),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(device.title,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 2),
                    Text(device.subtitle,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black.withOpacity(0.55),
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
              ),
              _PowerButton(isOn: device.isOn, onTap: onToggle, accent: accent),
            ],
          ),

          const SizedBox(height: 12),

          if (hasSlider) ...[
            Row(
              children: [
                Text(device.sliderLabel!,
                    style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w800)),
                const Spacer(),
                Text(
                  '${device.sliderValue}${device.sliderUnit}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const SizedBox(height: 6),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
              ),
              child: Slider(
                value: device.sliderValue.toDouble(),
                min: device.sliderMin.toDouble(),
                max: device.sliderMax.toDouble(),
                onChanged: device.isOn ? onSlider : null,
              ),
            ),
            const SizedBox(height: 8),
          ],

          Row(
            children: [
              Text('Power Usage',
                  style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.w800)),
              const Spacer(),
              Text(
                device.isOn ? '${device.powerWhenOn}W' : '0W',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: const Color(0xFF2D66F6)),
    );
  }
}

class _PowerButton extends StatelessWidget {
  const _PowerButton({required this.isOn, required this.onTap, required this.accent});
  final bool isOn;
  final VoidCallback onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isOn ? accent : const Color(0xFFEFF2F6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.power_settings_new,
          color: isOn ? Colors.white : Colors.black.withOpacity(0.55),
          size: 20,
        ),
      ),
    );
  }
}

/* ---------------- model ---------------- */

class _DeviceModel {
  _DeviceModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isOn,
    required this.hasSlider,
    required this.powerWhenOn,
    this.sliderLabel,
    this.sliderUnit = '',
    this.sliderValue = 0,
    this.sliderMin = 0,
    this.sliderMax = 100,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;

  bool isOn;

  final bool hasSlider;

  final int powerWhenOn;

  final String? sliderLabel;
  final String sliderUnit;
  int sliderValue;
  final int sliderMin;
  final int sliderMax;
}
