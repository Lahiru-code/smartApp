import 'package:flutter/material.dart';

import 'ui/login/admin_login_screen.dart';
import 'ui/login/teacher_login_screen.dart';
import 'ui/login/student_login_screen.dart';

import 'ui/pages/dashboard_screen.dart';
import 'ui/pages/environmental_screen.dart';
import 'ui/pages/device_control_screen.dart';
import 'ui/pages/attendance_screen.dart';
import 'ui/pages/ai_teacher_screen.dart';
import 'ui/pages/learning_screen.dart';
import 'ui/pages/progress_screen.dart';
import 'ui/pages/ai_management_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Classroom IoT',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D66F6)),
        scaffoldBackgroundColor: const Color(0xFFF6F9FF),
      ),
      initialRoute: '/login/admin',
      routes: {
        '/login/admin': (_) => const AdminLoginScreen(),
        '/login/teacher': (_) => const TeacherLoginScreen(),
        '/login/student': (_) => const StudentLoginScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/environmental': (_) => const EnvironmentalScreen(),
        '/device-control': (_) => const DeviceControlScreen(),
        '/attendance': (_) => const AttendanceScreen(),
        '/ai-teacher': (_) => const AiTeacherScreen(),
        '/learning': (_) => const LearningScreen(),
        '/progress': (_) => const ProgressScreen(),
        '/ai-management': (_) => const AiManagementScreen(),
      },
    );
  }
}
