import 'package:flutter/material.dart';
import 'smart_login_page.dart';
import '../../core/network/api_client.dart';
import '../../core/storage/secure_storage.dart';

class TeacherLoginScreen extends StatelessWidget {
  const TeacherLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = SecureStorage();
    final api = ApiClient(storage);
    return SmartLoginPage(
      role: UserRole.teacher,
      onQuickRoleTap: (role) {
        switch (role) {
          case UserRole.admin:
            Navigator.pushReplacementNamed(context, '/login/admin');
            break;
          case UserRole.teacher:
            break;
          case UserRole.student:
            Navigator.pushReplacementNamed(context, '/login/student');
            break;
        }
      },
      onSignIn: (email, password, role) async {
        try {
          final token = await api.login(email: email, password: password);
          await storage.writeToken(token);
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          }
        } on Exception catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${e.toString()}')),
          );
        }
      },
    );
  }
}
