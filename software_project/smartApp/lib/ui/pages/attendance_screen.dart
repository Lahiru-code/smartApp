/*import 'package:flutter/material.dart';
import 'app_shell.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String filter = 'all';

  final List<_AttendanceRow> rows = const [
    _AttendanceRow(
        id: 'STU1000',
        name: 'Student 1',
        time: '3:34:07 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1001',
        name: 'Student 2',
        time: '3:18:09 PM',
        method: 'FACIAL',
        status: 'late'),
    _AttendanceRow(
        id: 'STU1002',
        name: 'Student 3',
        time: '3:17:11 PM',
        method: 'RFID',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1003',
        name: 'Student 4',
        time: '2:49:13 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1004',
        name: 'Student 5',
        time: '3:08:37 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1005',
        name: 'Student 6',
        time: '3:43:37 PM',
        method: 'RFID',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1006',
        name: 'Student 7',
        time: '3:21:29 PM',
        method: 'RFID',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1007',
        name: 'Student 8',
        time: '3:22:02 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1008',
        name: 'Student 9',
        time: '3:25:56 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1009',
        name: 'Student 10',
        time: '3:07:12 PM',
        method: 'RFID',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1010',
        name: 'Student 11',
        time: '3:14:57 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1011',
        name: 'Student 12',
        time: '3:25:25 PM',
        method: 'FACIAL',
        status: 'late'),
    _AttendanceRow(
        id: 'STU1012',
        name: 'Student 13',
        time: '3:28:36 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1013',
        name: 'Student 14',
        time: '3:16:34 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1014',
        name: 'Student 15',
        time: '3:29:03 PM',
        method: 'FACIAL',
        status: 'present'),
  ];

  List<_AttendanceRow> get filteredRows {
    if (filter == 'all') return rows;
    return rows.where((r) => r.status == filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Attendance Management',
      subtitle: 'Track student attendance with RFID and facial recognition',
      selectedRoute: '/attendance',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopStats(
            total: rows.length,
            present: rows.where((e) => e.status == 'present').length,
            late: rows.where((e) => e.status == 'late').length,
            rate: _calcRate(),
          ),
          const SizedBox(height: 16),
          _TwoPanelRow(
            left: const _CameraCard(),
            right: const _RfidCard(),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _FilterChipRow(
                value: filter,
                onChanged: (v) => setState(() => filter = v),
              ),
              const Spacer(),
              _ExportButton(onTap: () {
                // TODO: export (csv/pdf) later
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Export report (TODO)')),
                );
              }),
            ],
          ),
          const SizedBox(height: 14),
          _AttendanceTable(rows: filteredRows),
        ],
      ),
    );
  }

  int _calcRate() {
    final present = rows.where((e) => e.status == 'present').length;
    return ((present / rows.length) * 100).round();
  }
}

/* ---------------- widgets ---------------- */

class _TopStats extends StatelessWidget {
  const _TopStats({
    required this.total,
    required this.present,
    required this.late,
    required this.rate,
  });

  final int total;
  final int present;
  final int late;
  final int rate;

  bool _wide(BuildContext c) => MediaQuery.of(c).size.width >= 980;
  bool _mid(BuildContext c) => MediaQuery.of(c).size.width >= 680;

  @override
  Widget build(BuildContext context) {
    final columns = _wide(context) ? 4 : (_mid(context) ? 2 : 1);

    return _Grid(
      columns: columns,
      children: [
        _StatCard(title: 'Total Students', value: '$total'),
        _StatCard(
            title: 'Present',
            value: '$present',
            accent: const Color(0xFF16A34A)),
        _StatCard(
            title: 'Late', value: '$late', accent: const Color(0xFFF59E0B)),
        _StatCard(
            title: 'Attendance\nRate',
            value: '$rate %',
            accent: const Color(0xFF2D66F6)),
      ],
    );
  }
}

class _TwoPanelRow extends StatelessWidget {
  const _TwoPanelRow({required this.left, required this.right});
  final Widget left;
  final Widget right;

  bool _wide(BuildContext c) => MediaQuery.of(c).size.width >= 980;

  @override
  Widget build(BuildContext context) {
    if (_wide(context)) {
      return Row(
        children: [
          Expanded(child: left),
          const SizedBox(width: 14),
          Expanded(child: right),
        ],
      );
    }
    return Column(
      children: [
        left,
        const SizedBox(height: 14),
        right,
      ],
    );
  }
}

class _CameraCard extends StatelessWidget {
  const _CameraCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Facial Recognition Camera',
      icon: Icons.photo_camera_outlined,
      iconColor: const Color(0xFF2D66F6),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: const Color(0xFF0B1220),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black.withOpacity(0.08)),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.photo_camera_outlined,
                  color: Colors.white.withOpacity(0.30), size: 42),
              const SizedBox(height: 10),
              Text('Camera feed active',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.65),
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text('Detecting faces...',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.40), fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

class _RfidCard extends StatelessWidget {
  const _RfidCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'RFID Scanner',
      icon: Icons.credit_card_outlined,
      iconColor: const Color(0xFF16A34A),
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F9FF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black.withOpacity(0.06)),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDFBE7),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Icon(Icons.how_to_reg_outlined,
                    color: Color(0xFF16A34A), size: 34),
              ),
              const SizedBox(height: 12),
              const Text('Ready to scan',
                  style: TextStyle(fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text('Place card near reader',
                  style: TextStyle(
                      fontSize: 12, color: Colors.black.withOpacity(0.55))),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChipRow extends StatelessWidget {
  const _FilterChipRow({required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        _Pill(
            value: 'all',
            label: 'all',
            selected: value == 'all',
            onTap: () => onChanged('all')),
        _Pill(
            value: 'present',
            label: 'present',
            selected: value == 'present',
            onTap: () => onChanged('present')),
        _Pill(
            value: 'late',
            label: 'late',
            selected: value == 'late',
            onTap: () => onChanged('late')),
        _Pill(
            value: 'absent',
            label: 'absent',
            selected: value == 'absent',
            onTap: () => onChanged('absent')),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(
      {required this.value,
      required this.label,
      required this.selected,
      required this.onTap});
  final String value;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? const Color(0xFF2D66F6) : const Color(0xFFEFF4FF);
    final fg = selected ? Colors.white : const Color(0xFF334155);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w800, color: fg)),
      ),
    );
  }
}

class _ExportButton extends StatelessWidget {
  const _ExportButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.download, size: 18),
        label: const Text('Export Report'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF16A34A),
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle:
              const TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5),
        ),
      ),
    );
  }
}

class _AttendanceTable extends StatelessWidget {
  const _AttendanceTable({required this.rows});
  final List<_AttendanceRow> rows;

  bool _wide(BuildContext c) => MediaQuery.of(c).size.width >= 980;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
              blurRadius: 26,
              offset: const Offset(0, 16),
              color: Colors.black.withOpacity(0.08)),
        ],
      ),
      child: Column(
        children: [
          _TableHeader(wide: _wide(context)),
          const SizedBox(height: 6),
          ...rows
              .map((r) => _TableRowItem(row: r, wide: _wide(context)))
              .toList(),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({required this.wide});
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
        fontSize: 11,
        color: Colors.black.withOpacity(0.55),
        fontWeight: FontWeight.w800);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(flex: 18, child: Text('Student ID', style: style)),
          Expanded(flex: 22, child: Text('Name', style: style)),
          Expanded(flex: 18, child: Text('Time', style: style)),
          if (wide) Expanded(flex: 18, child: Text('Method', style: style)),
          Expanded(flex: 18, child: Text('Status', style: style)),
        ],
      ),
    );
  }
}

class _TableRowItem extends StatelessWidget {
  const _TableRowItem({required this.row, required this.wide});
  final _AttendanceRow row;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.06))),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 18,
              child: Text(row.id,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w800))),
          Expanded(
              flex: 22,
              child: Text(row.name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700))),
          Expanded(
              flex: 18,
              child: Text(row.time,
                  style: TextStyle(
                      fontSize: 12, color: Colors.black.withOpacity(0.60)))),
          if (wide) Expanded(flex: 18, child: _MethodBadge(method: row.method)),
          Expanded(flex: 18, child: _StatusBadge(status: row.status)),
        ],
      ),
    );
  }
}

class _MethodBadge extends StatelessWidget {
  const _MethodBadge({required this.method});
  final String method;

  @override
  Widget build(BuildContext context) {
    final isFacial = method.toUpperCase() == 'FACIAL';
    final bg = isFacial ? const Color(0xFFEFE3FF) : const Color(0xFFDDEBFF);
    final fg = isFacial ? const Color(0xFF7C3AED) : const Color(0xFF2563EB);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isFacial ? Icons.camera_alt_outlined : Icons.nfc_outlined,
                size: 14, color: fg),
            const SizedBox(width: 6),
            Text(method,
                style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w900, color: fg)),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final s = status.toLowerCase();
    final bg = s == 'present'
        ? const Color(0xFFDDFBE7)
        : (s == 'late' ? const Color(0xFFFFE9B8) : const Color(0xFFEFF4FF));
    final fg = s == 'present'
        ? const Color(0xFF16A34A)
        : (s == 'late' ? const Color(0xFFF59E0B) : const Color(0xFF2D66F6));

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          s,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: fg),
        ),
      ),
    );
  }
}

/* ---- small shared ---- */

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
        children:
            children.map((e) => SizedBox(width: itemW, child: e)).toList(),
      );
    });
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.value, this.accent});
  final String title;
  final String value;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final a = accent ?? const Color(0xFF0F172A);
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
              color: Colors.black.withOpacity(0.08)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w800)),
          const Spacer(),
          Text(value,
              style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.w900, color: a)),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard(
      {required this.title,
      required this.icon,
      required this.iconColor,
      required this.child});

  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
              blurRadius: 26,
              offset: const Offset(0, 16),
              color: Colors.black.withOpacity(0.08)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontSize: 13.5, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/* ---- model ---- */

class _AttendanceRow {
  final String id;
  final String name;
  final String time;
  final String method;
  final String status;

  const _AttendanceRow({
    required this.id,
    required this.name,
    required this.time,
    required this.method,
    required this.status,
  });
}
*/



import 'package:flutter/material.dart';
import 'app_shell.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String filter = 'all';

  final List<_AttendanceRow> rows = const [
    _AttendanceRow(
        id: 'STU1000',
        name: 'Student 1',
        time: '3:34:07 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1001',
        name: 'Student 2',
        time: '3:18:09 PM',
        method: 'FACIAL',
        status: 'late'),
    _AttendanceRow(
        id: 'STU1002',
        name: 'Student 3',
        time: '3:17:11 PM',
        method: 'RFID',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1003',
        name: 'Student 4',
        time: '2:49:13 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1004',
        name: 'Student 5',
        time: '3:08:37 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1005',
        name: 'Student 6',
        time: '3:43:37 PM',
        method: 'RFID',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1006',
        name: 'Student 7',
        time: '3:21:29 PM',
        method: 'RFID',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1007',
        name: 'Student 8',
        time: '3:22:02 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1008',
        name: 'Student 9',
        time: '3:25:56 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1009',
        name: 'Student 10',
        time: '3:07:12 PM',
        method: 'RFID',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1010',
        name: 'Student 11',
        time: '3:14:57 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1011',
        name: 'Student 12',
        time: '3:25:25 PM',
        method: 'FACIAL',
        status: 'late'),
    _AttendanceRow(
        id: 'STU1012',
        name: 'Student 13',
        time: '3:28:36 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1013',
        name: 'Student 14',
        time: '3:16:34 PM',
        method: 'FACIAL',
        status: 'present'),
    _AttendanceRow(
        id: 'STU1014',
        name: 'Student 15',
        time: '3:29:03 PM',
        method: 'FACIAL',
        status: 'present'),
  ];

  List<_AttendanceRow> get filteredRows {
    if (filter == 'all') return rows;
    return rows.where((r) => r.status == filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Attendance Management',
      subtitle: 'Track student attendance with RFID and facial recognition',
      selectedRoute: '/attendance',

      // ✅ FIX: make the whole page scrollable
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TopStats(
              total: rows.length,
              present: rows.where((e) => e.status == 'present').length,
              late: rows.where((e) => e.status == 'late').length,
              rate: _calcRate(),
            ),
            const SizedBox(height: 16),
            const _TwoPanelRow(
              left: _CameraCard(),
              right: _RfidCard(),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _FilterChipRow(
                  value: filter,
                  onChanged: (v) => setState(() => filter = v),
                ),
                const Spacer(),
                _ExportButton(onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Export report (TODO)')),
                  );
                }),
              ],
            ),
            const SizedBox(height: 14),
            _AttendanceTable(rows: filteredRows),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  int _calcRate() {
    final present = rows.where((e) => e.status == 'present').length;
    return ((present / rows.length) * 100).round();
  }
}

/* ---------------- widgets ---------------- */

class _TopStats extends StatelessWidget {
  const _TopStats({
    required this.total,
    required this.present,
    required this.late,
    required this.rate,
  });

  final int total;
  final int present;
  final int late;
  final int rate;

  bool _wide(BuildContext c) => MediaQuery.of(c).size.width >= 980;
  bool _mid(BuildContext c) => MediaQuery.of(c).size.width >= 680;

  @override
  Widget build(BuildContext context) {
    final columns = _wide(context) ? 4 : (_mid(context) ? 2 : 1);

    return _Grid(
      columns: columns,
      children: [
        _StatCard(title: 'Total Students', value: '$total'),
        const _StatCard(
          title: 'Present',
          value: ' ',
          // dummy replaced below
        ),
        const SizedBox.shrink(),
        const SizedBox.shrink(),
      ].asMap().entries.map((entry) {
        final i = entry.key;
        if (i == 0) return _StatCard(title: 'Total Students', value: '$total');

        if (i == 1) {
          return _StatCard(
              title: 'Present',
              value: '$present',
              accent: const Color(0xFF16A34A));
        }

        if (i == 2) {
          return _StatCard(
              title: 'Late',
              value: '$late',
              accent: const Color(0xFFF59E0B));
        }

        return _StatCard(
            title: 'Attendance\nRate',
            value: '$rate %',
            accent: const Color(0xFF2D66F6));
      }).toList(),
    );
  }
}

class _TwoPanelRow extends StatelessWidget {
  const _TwoPanelRow({required this.left, required this.right});
  final Widget left;
  final Widget right;

  bool _wide(BuildContext c) => MediaQuery.of(c).size.width >= 980;

  @override
  Widget build(BuildContext context) {
    if (_wide(context)) {
      return Row(
        children: [
          Expanded(child: left),
          const SizedBox(width: 14),
          Expanded(child: right),
        ],
      );
    }
    return Column(
      children: [
        left,
        const SizedBox(height: 14),
        right,
      ],
    );
  }
}

class _CameraCard extends StatelessWidget {
  const _CameraCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Facial Recognition Camera',
      icon: Icons.photo_camera_outlined,
      iconColor: const Color(0xFF2D66F6),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: const Color(0xFF0B1220),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black.withOpacity(0.08)),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.photo_camera_outlined,
                  color: Colors.white.withOpacity(0.30), size: 42),
              const SizedBox(height: 10),
              Text('Camera feed active',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.65),
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text('Detecting faces...',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.40), fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

class _RfidCard extends StatelessWidget {
  const _RfidCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'RFID Scanner',
      icon: Icons.credit_card_outlined,
      iconColor: const Color(0xFF16A34A),
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F9FF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black.withOpacity(0.06)),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDFBE7),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Icon(Icons.how_to_reg_outlined,
                    color: Color(0xFF16A34A), size: 34),
              ),
              const SizedBox(height: 12),
              const Text('Ready to scan',
                  style: TextStyle(fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text('Place card near reader',
                  style: TextStyle(
                      fontSize: 12, color: Colors.black.withOpacity(0.55))),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChipRow extends StatelessWidget {
  const _FilterChipRow({required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        _Pill(
            value: 'all',
            label: 'all',
            selected: value == 'all',
            onTap: () => onChanged('all')),
        _Pill(
            value: 'present',
            label: 'present',
            selected: value == 'present',
            onTap: () => onChanged('present')),
        _Pill(
            value: 'late',
            label: 'late',
            selected: value == 'late',
            onTap: () => onChanged('late')),
        _Pill(
            value: 'absent',
            label: 'absent',
            selected: value == 'absent',
            onTap: () => onChanged('absent')),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(
      {required this.value,
      required this.label,
      required this.selected,
      required this.onTap});
  final String value;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? const Color(0xFF2D66F6) : const Color(0xFFEFF4FF);
    final fg = selected ? Colors.white : const Color(0xFF334155);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w800, color: fg)),
      ),
    );
  }
}

class _ExportButton extends StatelessWidget {
  const _ExportButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.download, size: 18),
        label: const Text('Export Report'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF16A34A),
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle:
              const TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5),
        ),
      ),
    );
  }
}

class _AttendanceTable extends StatelessWidget {
  const _AttendanceTable({required this.rows});
  final List<_AttendanceRow> rows;

  bool _wide(BuildContext c) => MediaQuery.of(c).size.width >= 980;

  @override
  Widget build(BuildContext context) {
    final wide = _wide(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
              blurRadius: 26,
              offset: const Offset(0, 16),
              color: Colors.black.withOpacity(0.08)),
        ],
      ),
      child: Column(
        children: [
          _TableHeader(wide: wide),
          const SizedBox(height: 6),

          // ✅ safe in SingleChildScrollView (no inner scrolling)
          ...rows.map((r) => _TableRowItem(row: r, wide: wide)).toList(),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({required this.wide});
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
        fontSize: 11,
        color: Colors.black.withOpacity(0.55),
        fontWeight: FontWeight.w800);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(flex: 18, child: Text('Student ID', style: style)),
          Expanded(flex: 22, child: Text('Name', style: style)),
          Expanded(flex: 18, child: Text('Time', style: style)),
          if (wide) Expanded(flex: 18, child: Text('Method', style: style)),
          Expanded(flex: 18, child: Text('Status', style: style)),
        ],
      ),
    );
  }
}

class _TableRowItem extends StatelessWidget {
  const _TableRowItem({required this.row, required this.wide});
  final _AttendanceRow row;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.06))),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 18,
              child: Text(row.id,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w800))),
          Expanded(
              flex: 22,
              child: Text(row.name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700))),
          Expanded(
              flex: 18,
              child: Text(row.time,
                  style: TextStyle(
                      fontSize: 12, color: Colors.black.withOpacity(0.60)))),
          if (wide) Expanded(flex: 18, child: _MethodBadge(method: row.method)),
          Expanded(flex: 18, child: _StatusBadge(status: row.status)),
        ],
      ),
    );
  }
}

class _MethodBadge extends StatelessWidget {
  const _MethodBadge({required this.method});
  final String method;

  @override
  Widget build(BuildContext context) {
    final isFacial = method.toUpperCase() == 'FACIAL';
    final bg = isFacial ? const Color(0xFFEFE3FF) : const Color(0xFFDDEBFF);
    final fg = isFacial ? const Color(0xFF7C3AED) : const Color(0xFF2563EB);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isFacial ? Icons.camera_alt_outlined : Icons.nfc_outlined,
                size: 14, color: fg),
            const SizedBox(width: 6),
            Text(method,
                style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w900, color: fg)),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final s = status.toLowerCase();
    final bg = s == 'present'
        ? const Color(0xFFDDFBE7)
        : (s == 'late' ? const Color(0xFFFFE9B8) : const Color(0xFFEFF4FF));
    final fg = s == 'present'
        ? const Color(0xFF16A34A)
        : (s == 'late' ? const Color(0xFFF59E0B) : const Color(0xFF2D66F6));

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          s,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: fg),
        ),
      ),
    );
  }
}

/* ---- small shared ---- */

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
        children:
            children.map((e) => SizedBox(width: itemW, child: e)).toList(),
      );
    });
  }
}

/// ✅ FIXED StatCard (no overflow)
class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.value, this.accent});
  final String title;
  final String value;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final a = accent ?? const Color(0xFF0F172A);

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
              color: Colors.black.withOpacity(0.08)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: a,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard(
      {required this.title,
      required this.icon,
      required this.iconColor,
      required this.child});

  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
              blurRadius: 26,
              offset: const Offset(0, 16),
              color: Colors.black.withOpacity(0.08)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontSize: 13.5, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/* ---- model ---- */

class _AttendanceRow {
  final String id;
  final String name;
  final String time;
  final String method;
  final String status;

  const _AttendanceRow({
    required this.id,
    required this.name,
    required this.time,
    required this.method,
    required this.status,
  });
}
