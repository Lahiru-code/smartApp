//slide bar + layout

/*import 'package:flutter/material.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selectedRoute,
    required this.body,
    this.actions,
  });

  final String title;
  final String subtitle;
  final String selectedRoute;
  final Widget body;
  final List<Widget>? actions;

  static const _sidebarWidth = 260.0;

  bool _isWide(BuildContext context) =>
      MediaQuery.of(context).size.width >= 980;

  @override
  Widget build(BuildContext context) {
    final wide = _isWide(context);

    final sidebar = _Sidebar(
      selectedRoute: selectedRoute,
      onNavigate: (route) {
        if (ModalRoute.of(context)?.settings.name == route) return;
        Navigator.pushReplacementNamed(context, route);
      },
    );

    return Scaffold(
      drawer: wide ? null : Drawer(child: SafeArea(child: sidebar)),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF3F6FF), Color(0xFFF5FCFF), Color(0xFFFFF8F0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              if (wide)
                SizedBox(
                  width: _sidebarWidth,
                  child: sidebar,
                ),
              Expanded(
                child: Column(
                  children: [
                    _TopBar(
                      title: title,
                      subtitle: subtitle,
                      showMenu: !wide,
                      actions: actions,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
                        child: body,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.subtitle,
    required this.showMenu,
    this.actions,
  });

  final String title;
  final String subtitle;
  final bool showMenu;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        border: Border(
          bottom: BorderSide(color: Colors.black.withOpacity(0.06)),
        ),
      ),
      child: Row(
        children: [
          if (showMenu)
            IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu),
            ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    )),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.55),
                    )),
              ],
            ),
          ),
          ...(actions ?? []),
          const SizedBox(width: 6),
          _UserPill(),
        ],
      ),
    );
  }
}

class _UserPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 12,
            backgroundColor: Color(0xFF2D66F6),
            child: Icon(Icons.person, size: 14, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Admin User',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              Text('admin',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black.withOpacity(0.55),
                  )),
            ],
          ),
          const SizedBox(width: 10),
          Icon(Icons.logout, size: 18, color: Colors.red.withOpacity(0.85)),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({required this.selectedRoute, required this.onNavigate});

  final String selectedRoute;
  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.7),
      child: Column(
        children: [
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D66F6),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                        color: Colors.black.withOpacity(0.12),
                      )
                    ],
                  ),
                  child:
                      const Icon(Icons.grid_view_rounded, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Smart Classroom',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 14)),
                      SizedBox(height: 2),
                      Text('IoT Management',
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _NavItem(
            icon: Icons.dashboard_outlined,
            label: 'Dashboard',
            selected: selectedRoute == '/dashboard',
            onTap: () => onNavigate('/dashboard'),
          ),
          _NavItem(
            icon: Icons.thermostat_outlined,
            label: 'Environmental',
            selected: selectedRoute == '/environmental',
            onTap: () => onNavigate('/environmental'),
          ),
          _NavItem(
            icon: Icons.power_settings_new,
            label: 'Device Control',
            selected: selectedRoute == '/device-control',
            onTap: () => onNavigate('/device-control'),
          ),
          _NavItem(
              icon: Icons.query_stats_outlined,
              label: 'Analytics',
              selected: selectedRoute == '/analytics',
              onTap: () => onNavigate('/analytics')),
          _NavItem(
              icon: Icons.calendar_month_outlined,
              label: 'Schedule',
              selected: selectedRoute == '/schedule',
              onTap: () => onNavigate('/schedule')),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'AI TEACHING ASSISTANT',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.45),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _NavItem(
              icon: Icons.smart_toy_outlined,
              label: 'AI Teacher',
              selected: selectedRoute == '/ai-teacher',
              onTap: () => onNavigate('/ai-teacher')),
          _NavItem(
              icon: Icons.menu_book_outlined,
              label: 'Learning',
              selected: selectedRoute == '/learning',
              onTap: () => onNavigate('/learning')),
          _NavItem(
              icon: Icons.trending_up_outlined,
              label: 'Progress',
              selected: selectedRoute == '/progress',
              onTap: () => onNavigate('/progress')),
          _NavItem(
            icon: Icons.settings_suggest_outlined,
            label: 'AI Management',
            selected: selectedRoute == '/ai-management',
            onTap: () => onNavigate('/ai-management'),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF1FF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.black.withOpacity(0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('System Status',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.circle, size: 10, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'All systems operational',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? const Color(0xFFEAF1FF) : Colors.transparent;
    final fg = selected ? const Color(0xFF2D66F6) : const Color(0xFF334155);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(icon, size: 20, color: fg),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700, color: fg),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
//after overflow sloving
import 'package:flutter/material.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selectedRoute,
    required this.body,
    this.actions,
  });

  final String title;
  final String subtitle;
  final String selectedRoute;
  final Widget body;
  final List<Widget>? actions;

  static const _sidebarWidth = 260.0;

  bool _isWide(BuildContext context) =>
      MediaQuery.of(context).size.width >= 980;

  @override
  Widget build(BuildContext context) {
    final wide = _isWide(context);

    final sidebar = _Sidebar(
      selectedRoute: selectedRoute,
      onNavigate: (route) {
        if (ModalRoute.of(context)?.settings.name == route) return;
        Navigator.pushReplacementNamed(context, route);
      },
    );

    return Scaffold(
      drawer: wide ? null : Drawer(child: SafeArea(child: sidebar)),
      body: SafeArea(
        child: Row(
          children: [
            if (wide)
              SizedBox(
                width: _sidebarWidth,
                child: sidebar,
              ),
            Expanded(
              child: Column(
                children: [
                  _TopBar(
                    title: title,
                    subtitle: subtitle,
                    showMenu: !wide,
                    actions: actions,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
                      child: body,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.subtitle,
    required this.showMenu,
    this.actions,
  });

  final String title;
  final String subtitle;
  final bool showMenu;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFDFEFF), Color(0xFFF3F8FF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border(
          bottom: BorderSide(color: const Color(0xFF2D66F6).withOpacity(0.14)),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D66F6).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (showMenu)
            Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu, color: Color(0xFF3657C8)),
              ),
            ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF3F5F9E).withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
          ...(actions ?? []),
          const SizedBox(width: 6),
          _UserPill(),
        ],
      ),
    );
  }
}

class _UserPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2D66F6), Color(0xFF00A7E8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF1E4FC3).withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.person_outlined,
              size: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Admin',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                'admin@school.com',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.logout_outlined,
            size: 18,
            color: Colors.white.withOpacity(0.95),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({required this.selectedRoute, required this.onNavigate});

  final String selectedRoute;
  final void Function(String route) onNavigate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEDF3FF), Color(0xFFF3FAFF), Color(0xFFFFF6EE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2D66F6), Color(0xFF7A5AF8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.school_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Smart Classroom',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Management',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _NavItem(
              icon: Icons.dashboard_outlined,
              label: 'Dashboard',
              selected: selectedRoute == '/dashboard',
              onTap: () => onNavigate('/dashboard'),
            ),
            _NavItem(
              icon: Icons.thermostat_outlined,
              label: 'Environmental',
              selected: selectedRoute == '/environmental',
              onTap: () => onNavigate('/environmental'),
            ),
            _NavItem(
              icon: Icons.power_settings_new,
              label: 'Device Control',
              selected: selectedRoute == '/device-control',
              onTap: () => onNavigate('/device-control'),
            ),
            _NavItem(
              icon: Icons.query_stats_outlined,
              label: 'Analytics',
              selected: selectedRoute == '/analytics',
              onTap: () => onNavigate('/analytics'),
            ),
            _NavItem(
              icon: Icons.calendar_month_outlined,
              label: 'Schedule',
              selected: selectedRoute == '/schedule',
              onTap: () => onNavigate('/schedule'),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'AI TEACHING ASSISTANT',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.45),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _NavItem(
              icon: Icons.smart_toy_outlined,
              label: 'AI Teacher',
              selected: selectedRoute == '/ai-teacher',
              onTap: () => onNavigate('/ai-teacher'),
            ),
            _NavItem(
              icon: Icons.menu_book_outlined,
              label: 'Learning',
              selected: selectedRoute == '/learning',
              onTap: () => onNavigate('/learning'),
            ),
            _NavItem(
              icon: Icons.trending_up_outlined,
              label: 'Progress',
              selected: selectedRoute == '/progress',
              onTap: () => onNavigate('/progress'),
            ),
            _NavItem(
              icon: Icons.settings_suggest_outlined,
              label: 'AI Management',
              selected: selectedRoute == '/ai-management',
              onTap: () => onNavigate('/ai-management'),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE8FFF2), Color(0xFFF4FFFA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: const Color(0xFF0F9D58).withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'System Status',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'All systems operational',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  Color _accentColor() {
    switch (label) {
      case 'Dashboard':
        return const Color(0xFF2D66F6);
      case 'Environmental':
        return const Color(0xFF0EA5E9);
      case 'Device Control':
        return const Color(0xFFF97316);
      case 'Analytics':
        return const Color(0xFF8B5CF6);
      case 'Schedule':
        return const Color(0xFFEC4899);
      case 'AI Teacher':
        return const Color(0xFF06B6D4);
      case 'Learning':
        return const Color(0xFF14B8A6);
      case 'Progress':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF6366F1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = _accentColor();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              gradient: selected
                  ? LinearGradient(
                      colors: [
                        accent.withOpacity(0.16),
                        accent.withOpacity(0.07)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
              color: selected ? null : Colors.white.withOpacity(0.35),
              borderRadius: BorderRadius.circular(12),
              border: selected
                  ? Border.all(
                      color: accent.withOpacity(0.35),
                    )
                  : Border.all(color: Colors.white.withOpacity(0.28)),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: selected ? accent : accent.withOpacity(0.82),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                      color: selected ? accent : const Color(0xFF334155),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
