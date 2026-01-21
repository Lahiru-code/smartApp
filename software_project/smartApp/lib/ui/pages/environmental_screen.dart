import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'app_shell.dart';

class EnvironmentalScreen extends StatelessWidget {
  const EnvironmentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell(
      title: 'Environmental Monitoring',
      subtitle: 'Real-time and historical environmental data',
      selectedRoute: '/environmental',
      body: _EnvironmentalBody(),
    );
  }
}

class _EnvironmentalBody extends StatelessWidget {
  const _EnvironmentalBody();

  bool _wide(BuildContext c) => MediaQuery.of(c).size.width >= 980;
  bool _mid(BuildContext c) => MediaQuery.of(c).size.width >= 680;

  @override
  Widget build(BuildContext context) {
    final columns = _wide(context) ? 3 : (_mid(context) ? 2 : 1);

    // Example bottom labels for last 20 minutes
    final bottomLabels = <double, String>{
      0: '20m',
      5: '15m',
      10: '10m',
      15: '5m',
      20: 'now',
    };

    // Example data (replace later with real data)
    final tempLine = LineChartBarData(
      isCurved: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      barWidth: 2.5,
      color: const Color(0xFF2D66F6),
      spots: const [
        FlSpot(0, 22.5),
        FlSpot(5, 22.8),
        FlSpot(10, 23.2),
        FlSpot(15, 23.7),
        FlSpot(20, 24.1),
      ],
    );

    final humLine = LineChartBarData(
      isCurved: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      barWidth: 2.5,
      color: const Color(0xFF16A34A),
      spots: const [
        FlSpot(0, 52),
        FlSpot(5, 50),
        FlSpot(10, 49),
        FlSpot(15, 48),
        FlSpot(20, 47),
      ],
    );

    final airLine = LineChartBarData(
      isCurved: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      barWidth: 2.5,
      color: const Color(0xFFF59E0B),
      spots: const [
        FlSpot(0, 360),
        FlSpot(5, 372),
        FlSpot(10, 385),
        FlSpot(15, 392),
        FlSpot(20, 378),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Grid(columns: columns, children: const [
          _MiniMetric(title: 'temperature', value: '22.5', unit: '°C'),
          _MiniMetric(title: 'humidity', value: '55.6', unit: '%'),
          _MiniMetric(title: 'air Quality', value: '378.5', unit: 'PPM'),
          _MiniMetric(title: 'light', value: '351.1', unit: 'Lux'),
          _MiniMetric(title: 'noise', value: '46.2', unit: 'dB'),
        ]),
        const SizedBox(height: 16),

        _CardSection(
          title: 'Historical Data (Last 20 minutes)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              const Text(
                'Temperature & Humidity',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              _LineChartCard(
                height: 220,
                lines: [tempLine, humLine],
                minX: 0,
                maxX: 20,
                minY: 0,
                maxY: 100,
                bottomLabels: bottomLabels,
              ),
              const SizedBox(height: 18),
              const Text(
                'Air Quality',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              _LineChartCard(
                height: 220,
                lines: [airLine],
                minX: 0,
                maxX: 20,
                minY: 300,
                maxY: 500,
                bottomLabels: bottomLabels,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        _CardSection(
          title: 'Alert Thresholds',
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: const [
                  Expanded(
                    child: _ThresholdItem(
                      label: 'Temperature Warning (°C)',
                      value: '26',
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: _ThresholdItem(
                      label: 'Humidity Warning (%)',
                      value: '70',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: const [
                  Expanded(
                    child: _ThresholdItem(
                      label: 'Air Quality Warning (PPM)',
                      value: '450',
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: _ThresholdItem(
                      label: 'Noise Level Warning (dB)',
                      value: '60',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Save Settings'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/* ---- widgets ---- */

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

/// ✅ FIXED: NO fixed height -> prevents overflow on small tiles
class _MiniMetric extends StatelessWidget {
  const _MiniMetric({
    required this.title,
    required this.value,
    required this.unit,
  });

  final String title;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 92),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.55),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.circle, size: 10, color: Colors.green),
              SizedBox(width: 8),
              Text(
                'normal',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardSection extends StatelessWidget {
  const _CardSection({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            blurRadius: 26,
            offset: const Offset(0, 16),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _ThresholdItem extends StatelessWidget {
  const _ThresholdItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F9FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w800,
              )),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

/// ✅ Real chart widget
class _LineChartCard extends StatelessWidget {
  const _LineChartCard({
    required this.height,
    required this.lines,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    this.bottomLabels,
  });

  final double height;
  final List<LineChartBarData> lines;
  final double minX, maxX, minY, maxY;

  /// map x value -> label text (example: 19 -> "19m ago")
  final Map<double, String>? bottomLabels;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F9FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: LineChart(
        LineChartData(
          minX: minX,
          maxX: maxX,
          minY: minY,
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: (maxY - minY) / 4,
            verticalInterval: 5,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.black.withOpacity(0.06),
              strokeWidth: 1,
            ),
            getDrawingVerticalLine: (value) => FlLine(
              color: Colors.black.withOpacity(0.04),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide(color: Colors.black.withOpacity(0.12)),
              bottom: BorderSide(color: Colors.black.withOpacity(0.12)),
              right: const BorderSide(color: Colors.transparent),
              top: const BorderSide(color: Colors.transparent),
            ),
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 34,
                interval: (maxY - minY) / 4,
                getTitlesWidget: (v, meta) => Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Text(
                    v.toStringAsFixed(0),
                    style: TextStyle(fontSize: 10.5, color: Colors.black.withOpacity(0.55)),
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 26,
                interval: 5,
                getTitlesWidget: (v, meta) {
                  final txt = bottomLabels?[v] ?? '';
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      txt,
                      style: TextStyle(fontSize: 10.5, color: Colors.black.withOpacity(0.55)),
                    ),
                  );
                },
              ),
            ),
          ),
          lineBarsData: lines,
        ),
      ),
    );
  }
}
