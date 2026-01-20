import 'package:flutter/material.dart';
import 'app_shell.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  bool _wide(BuildContext c) => MediaQuery.of(c).size.width >= 980;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Class Schedule',
      subtitle: 'Manage classroom bookings and timetables',
      selectedRoute: '/schedule',
      actions: [
        SizedBox(
          height: 40,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('New Booking'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D66F6),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5),
            ),
          ),
        ),
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _WeeklyScheduleCard(wide: _wide(context)),
          const SizedBox(height: 16),
          const _UpcomingClassesCard(),
        ],
      ),
    );
  }
}

class _WeeklyScheduleCard extends StatelessWidget {
  const _WeeklyScheduleCard({required this.wide});
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final days = const ['Monday', 'Tuesday', 'Wednesday', 'Thursday'];
    final times = const [
      '8:00',
      '9:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
      '18:00',
      '19:00'
    ];

    return _CardSection(
      title: 'Weekly Schedule - Room 301',
      trailing: Row(
        children: [
          _SmallBtn(label: 'Previous Week', onTap: () {}),
          const SizedBox(width: 10),
          _SmallBtn(label: 'Next Week', onTap: () {}),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const SizedBox(
                    width: 90,
                    child: Text('Time',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 12))),
                ...days.map((d) => Expanded(
                      child: Text(d,
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 12)),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 520,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: times.length,
              itemBuilder: (_, i) {
                final t = times[i];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(t,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.65),
                                fontWeight: FontWeight.w700)),
                      ),
                      for (int d = 0; d < days.length; d++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: _slotCard(t, d),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _slotCard(String time, int dayIdx) {
    // Hard-coded demo slots like screenshot
    final isSlot = (dayIdx == 0 && time == '9:00') ||
        (dayIdx == 0 && time == '11:00') ||
        (dayIdx == 0 && time == '14:00');

    if (!isSlot) return const SizedBox(height: 54);

    String title = 'Computer\nScience 301';
    String sub = 'Dr. Smith';

    if (time == '11:00') {
      title = 'Mathematics\n201';
      sub = 'Prof. Johnson';
    }
    if (time == '14:00') {
      title = 'Physics Lab';
      sub = 'Dr. Williams';
    }

    return Container(
      height: 54,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFDCEBFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontWeight: FontWeight.w900, fontSize: 11)),
          const Spacer(),
          Text(sub,
              style: TextStyle(
                  fontSize: 10.5,
                  color: Colors.black.withOpacity(0.55),
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _UpcomingClassesCard extends StatelessWidget {
  const _UpcomingClassesCard();

  @override
  Widget build(BuildContext context) {
    return _CardSection(
      title: 'Upcoming Classes',
      child: Column(
        children: const [
          _UpcomingTile(
            title: 'Computer Science 301',
            teacher: 'Dr. Smith',
            room: 'Room 301',
            time: '09:00 AM  – 10:30 AM',
            status: 'scheduled',
          ),
          SizedBox(height: 12),
          _UpcomingTile(
            title: 'Mathematics 201',
            teacher: 'Prof. Johnson',
            room: 'Room 301',
            time: '11:00 AM  – 12:30 PM',
            status: 'scheduled',
          ),
          SizedBox(height: 12),
          _UpcomingTile(
            title: 'Physics Lab',
            teacher: 'Dr. Williams',
            room: 'Room 301',
            time: '02:00 PM  – 04:00 PM',
            status: 'scheduled',
          ),
        ],
      ),
    );
  }
}

/* ------- shared ui ------- */

class _CardSection extends StatelessWidget {
  const _CardSection({required this.title, required this.child, this.trailing});

  final String title;
  final Widget child;
  final Widget? trailing;

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
              color: Colors.black.withOpacity(0.08)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 14.5, fontWeight: FontWeight.w900))),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _SmallBtn extends StatelessWidget {
  const _SmallBtn({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEFF4FF),
          foregroundColor: const Color(0xFF0F172A),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
        ),
        child: Text(label),
      ),
    );
  }
}

class _UpcomingTile extends StatelessWidget {
  const _UpcomingTile({
    required this.title,
    required this.teacher,
    required this.room,
    required this.time,
    required this.status,
  });

  final String title;
  final String teacher;
  final String room;
  final String time;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFDCEBFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.calendar_month, color: Color(0xFF2D66F6)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text('$teacher  •  $room',
                    style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.black.withOpacity(0.55),
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(time,
                    style: TextStyle(
                        fontSize: 11.5, color: Colors.black.withOpacity(0.55))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFDDFBE7),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(status,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF16A34A))),
          ),
        ],
      ),
    );
  }
}
