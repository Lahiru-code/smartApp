import 'package:flutter/material.dart';

import 'app_shell.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Dashboard',
      subtitle: 'Classroom overview and daily operations',
      selectedRoute: '/dashboard',
      actions: [
        IconButton(
          tooltip: 'Notifications',
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
        IconButton(
          tooltip: 'Refresh',
          onPressed: () {},
          icon: const Icon(Icons.refresh_outlined),
        ),
      ],
      body: const _DashboardBody(),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _GreetingWidget(),
          const SizedBox(height: 20),
          const _CalendarWidget(),
          const SizedBox(height: 20),
          const _DailyScheduleWidget(),
          const SizedBox(height: 20),
          const _QuickActionsWidget(),
          const SizedBox(height: 20),
          const _UpcomingEventsWidget(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// GREETING WIDGET
class _GreetingWidget extends StatelessWidget {
  const _GreetingWidget();

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? '🌅 Good Morning'
        : hour < 18
            ? '☀️ Good Afternoon'
            : '🌙 Good Evening';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2D66F6).withOpacity(0.9),
            const Color(0xFF00A7E8).withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D66F6).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Admin • Today is ${DateTime.now().toString().split(' ')[0]}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.85),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// CALENDAR WIDGET
class _CalendarWidget extends StatefulWidget {
  const _CalendarWidget();

  @override
  State<_CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<_CalendarWidget> {
  DateTime _selectedDate = DateTime.now();
  late DateTime _firstDayOfMonth;

  @override
  void initState() {
    super.initState();
    _firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth =
        DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;
    final dayOffset = _firstDayOfMonth.weekday - 1;
    final days = List.generate(daysInMonth, (i) => i + 1);
    const colors = [
      Color(0xFFFF6B6B), // Red
      Color(0xFF4ECDC4), // Teal
      Color(0xFFFFE66D), // Yellow
      Color(0xFF95E1D3), // Mint
      Color(0xFFC7CEEA), // Purple
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5EAF2), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '📅 ${[
                  'Jan',
                  'Feb',
                  'Mar',
                  'Apr',
                  'May',
                  'Jun',
                  'Jul',
                  'Aug',
                  'Sep',
                  'Oct',
                  'Nov',
                  'Dec'
                ][_selectedDate.month - 1]} ${_selectedDate.year}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedDate = DateTime(
                            _selectedDate.year, _selectedDate.month - 1);
                        _firstDayOfMonth = DateTime(
                            _selectedDate.year, _selectedDate.month, 1);
                      });
                    },
                    icon: const Icon(Icons.chevron_left),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedDate = DateTime(
                            _selectedDate.year, _selectedDate.month + 1);
                        _firstDayOfMonth = DateTime(
                            _selectedDate.year, _selectedDate.month, 1);
                      });
                    },
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...List.generate(
                  dayOffset, (i) => const SizedBox(width: 40, height: 40)),
              ...days.map((day) {
                final isToday = day == DateTime.now().day &&
                    _selectedDate.month == DateTime.now().month &&
                    _selectedDate.year == DateTime.now().year;
                final color = colors[day % colors.length];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = DateTime(
                          _selectedDate.year, _selectedDate.month, day);
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withOpacity(0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: isToday
                          ? Border.all(
                              color: const Color(0xFF0F172A),
                              width: 2,
                            )
                          : null,
                      boxShadow: isToday
                          ? [
                              BoxShadow(
                                color: color.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}

// DAILY SCHEDULE WIDGET
class _DailyScheduleWidget extends StatelessWidget {
  const _DailyScheduleWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5EAF2), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '⏰ Today\'s Schedule',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          _ScheduleItem(
            time: '08:30 - 09:00',
            title: 'Morning Briefing',
            room: 'Room 204',
            status: 'Now',
            color: const Color(0xFF22C55E),
            progress: 1.0,
          ),
          const SizedBox(height: 12),
          _ScheduleItem(
            time: '10:00 - 11:00',
            title: 'Mathematics Lesson',
            room: 'Room 204',
            status: 'Next (1h 15min)',
            color: const Color(0xFF2563EB),
            progress: 0.0,
          ),
          const SizedBox(height: 12),
          _ScheduleItem(
            time: '11:30 - 12:30',
            title: 'Science Lab Setup',
            room: 'Lab 2',
            status: 'Upcoming (2h 30min)',
            color: const Color(0xFFF59E0B),
            progress: 0.0,
          ),
        ],
      ),
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  final String time;
  final String title;
  final String room;
  final String status;
  final Color color;
  final double progress;

  const _ScheduleItem({
    required this.time,
    required this.title,
    required this.room,
    required this.status,
    required this.color,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$time • $room',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          if (progress > 0) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 4,
                backgroundColor: Colors.grey.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// QUICK ACTIONS WIDGET
class _QuickActionsWidget extends StatelessWidget {
  const _QuickActionsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            '⚡ Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _ActionWidget(
              icon: '✅',
              title: 'Attendance',
              color: const Color(0xFF2563EB),
            ),
            _ActionWidget(
              icon: '📱',
              title: 'Device Control',
              color: const Color(0xFF0F9D58),
            ),
            _ActionWidget(
              icon: '📊',
              title: 'Generate Report',
              color: const Color(0xFFF59E0B),
            ),
            _ActionWidget(
              icon: '💬',
              title: 'Message Class',
              color: const Color(0xFFEC4899),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionWidget extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;

  const _ActionWidget({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.15),
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.3), width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                icon,
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// UPCOMING EVENTS WIDGET
class _UpcomingEventsWidget extends StatelessWidget {
  const _UpcomingEventsWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5EAF2), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '📌 Upcoming Events',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF2563EB),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _EventItem(
            title: 'Parent-Teacher Meeting',
            date: 'May 5, 2024 • 3:30 PM',
            icon: '👥',
            color: const Color(0xFF8B5CF6),
          ),
          const SizedBox(height: 12),
          _EventItem(
            title: 'Annual Sports Day',
            date: 'May 10, 2024 • All Day',
            icon: '🏃',
            color: const Color(0xFFEC4899),
          ),
          const SizedBox(height: 12),
          _EventItem(
            title: 'Summer Break Begins',
            date: 'May 25, 2024',
            icon: '☀️',
            color: const Color(0xFFF59E0B),
          ),
        ],
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  final String title;
  final String date;
  final String icon;
  final Color color;

  const _EventItem({
    required this.title,
    required this.date,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.onExport, required this.onAddClass});

  final VoidCallback onExport;
  final VoidCallback onAddClass;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFFF4F7FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE3E8F2)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 680;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  const _HeaderText(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton.icon(
                        onPressed: onExport,
                        icon: const Icon(Icons.download_outlined, size: 18),
                        label: const Text('Export'),
                      ),
                      const SizedBox(width: 10),
                      FilledButton.icon(
                        onPressed: onAddClass,
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Add class'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  _MiniInfoChip(
                    icon: Icons.schedule_outlined,
                    label: 'Next class',
                    value: 'Math 10:30 AM',
                  ),
                  _MiniInfoChip(
                    icon: Icons.groups_outlined,
                    label: 'Today',
                    value: '186 students',
                  ),
                  _MiniInfoChip(
                    icon: Icons.wifi_tethering_outlined,
                    label: 'Devices online',
                    value: '24 of 26',
                  ),
                  _MiniInfoChip(
                    icon: Icons.thermostat_outlined,
                    label: 'Room temperature',
                    value: '24.1 C',
                  ),
                ],
              ),
              if (!stacked) const SizedBox(height: 4),
            ],
          );
        },
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  const _HeaderText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good morning, Admin',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'A quick look at attendance, devices, and class flow for today.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF64748B),
              ),
        ),
      ],
    );
  }
}

class _MiniInfoChip extends StatelessWidget {
  const _MiniInfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5EAF2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF1FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF3559C7)),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OverviewGrid extends StatelessWidget {
  const _OverviewGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width >= 1100
            ? 4
            : width >= 760
                ? 2
                : 1;

        final cards = const [
          _OverviewCard(
            icon: Icons.groups_outlined,
            label: 'Attendance',
            value: '94%',
            helper: '8 students absent',
            accent: Color(0xFF2563EB),
          ),
          _OverviewCard(
            icon: Icons.power_outlined,
            label: 'Devices online',
            value: '24 / 26',
            helper: '2 require attention',
            accent: Color(0xFF0F9D58),
          ),
          _OverviewCard(
            icon: Icons.report_outlined,
            label: 'Open alerts',
            value: '3',
            helper: '1 needs review',
            accent: Color(0xFFF59E0B),
          ),
          _OverviewCard(
            icon: Icons.signal_cellular_alt,
            label: 'Network',
            value: 'Stable',
            helper: 'Last sync 2 min ago',
            accent: Color(0xFF64748B),
          ),
        ];

        return Wrap(
          spacing: 14,
          runSpacing: 14,
          children: cards.map((card) {
            final itemWidth =
                columns == 1 ? width : (width - (columns - 1) * 14) / columns;
            return SizedBox(width: itemWidth, child: card);
          }).toList(),
        );
      },
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.helper,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final String value;
  final String helper;
  final Color accent;

  double _getProgressValue() {
    if (label == 'Attendance') return 0.94;
    if (label == 'Devices online') return 24 / 26;
    if (label == 'Open alerts') return 0.7;
    if (label == 'Network') return 1.0;
    return 0.75;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            accent.withOpacity(0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [accent, accent.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 26),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  label.split(' ').first,
                  style: TextStyle(
                    fontSize: 10,
                    color: accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: _getProgressValue(),
              minHeight: 6,
              backgroundColor: Colors.grey.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(accent),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            helper,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.65),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _AgendaCard extends StatelessWidget {
  const _AgendaCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5EAF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Today\'s schedule',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Main classes and room activities for this morning.',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.black.withOpacity(0.55),
            ),
          ),
          const SizedBox(height: 16),
          const _ScheduleRow(
            time: '08:30',
            title: 'Homeroom and attendance check',
            subtitle: 'Room 204 • 28 students',
            status: 'Now',
            statusColor: Color(0xFF0F9D58),
          ),
          const SizedBox(height: 10),
          const _ScheduleRow(
            time: '10:00',
            title: 'Mathematics lesson',
            subtitle: 'Room 204 • Teacher: Ms. Alvarez',
            status: 'Next',
            statusColor: Color(0xFF2563EB),
          ),
          const SizedBox(height: 10),
          const _ScheduleRow(
            time: '11:30',
            title: 'Science lab setup',
            subtitle: 'Lab 2 • Device check required',
            status: 'Prep',
            statusColor: Color(0xFFF59E0B),
          ),
        ],
      ),
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  const _ScheduleRow({
    required this.time,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusColor,
  });

  final String time;
  final String title;
  final String subtitle;
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5EAF2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 56,
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SideColumn extends StatelessWidget {
  const _SideColumn();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ActionsCard(),
        SizedBox(height: 16),
        _ActivityCard(),
      ],
    );
  }
}

class _ActionsCard extends StatelessWidget {
  const _ActionsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5EAF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick actions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          _ActionTile(
            icon: Icons.check_circle_outline,
            title: 'Mark attendance',
            subtitle: 'Open the daily list',
            color: const Color(0xFF2563EB),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          _ActionTile(
            icon: Icons.power_settings_new,
            title: 'Device control',
            subtitle: 'Adjust classroom equipment',
            color: const Color(0xFF0F9D58),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          _ActionTile(
            icon: Icons.description_outlined,
            title: 'Generate report',
            subtitle: 'Download a summary for today',
            color: const Color(0xFFF59E0B),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 16, color: color.withOpacity(0.6)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            const Color(0xFFFAFBFC),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5EAF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent activity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF2563EB),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _ActivityRow(
            title: 'Attendance completed for Room 204',
            subtitle: '2 minutes ago',
            icon: Icons.check_circle,
            color: const Color(0xFF0F9D58),
          ),
          const SizedBox(height: 12),
          _ActivityRow(
            title: 'Projector in Lab 2 switched on',
            subtitle: '14 minutes ago',
            icon: Icons.power,
            color: const Color(0xFF2563EB),
          ),
          const SizedBox(height: 12),
          _ActivityRow(
            title: 'Air filter reminder added for Friday',
            subtitle: 'Today, 7:40 AM',
            icon: Icons.event_note,
            color: const Color(0xFFF59E0B),
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.08),
            color.withOpacity(0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.55),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
