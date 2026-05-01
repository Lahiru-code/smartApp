import 'package:flutter/material.dart';

enum UserRole { admin, teacher, student }

extension UserRoleX on UserRole {
  String get label {
    switch (this) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.teacher:
        return 'Teacher';
      case UserRole.student:
        return 'Student';
    }
  }

  String get defaultEmail {
    switch (this) {
      case UserRole.admin:
        return 'admin@classroom.com';
      case UserRole.teacher:
        return 'teacher@classroom.com';
      case UserRole.student:
        return 'student@classroom.com';
    }
  }
}

class SmartLoginPage extends StatefulWidget {
  const SmartLoginPage({
    super.key,
    required this.role,
    this.onSignIn,
    this.onQuickRoleTap,
  });

  final UserRole role;
  final Future<void> Function(String email, String password, UserRole role)?
      onSignIn;
  final void Function(UserRole role)? onQuickRoleTap;

  @override
  State<SmartLoginPage> createState() => _SmartLoginPageState();
}

class _SmartLoginPageState extends State<SmartLoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  bool _obscure = true;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: widget.role.defaultEmail);
    _password = TextEditingController();
  }

  @override
  void didUpdateWidget(covariant SmartLoginPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.role != widget.role) {
      _email.text = widget.role.defaultEmail;
      _password.clear();
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    final email = _email.text.trim();
    final pass = _password.text;

    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    if (widget.onSignIn == null) return;

    setState(() => _loading = true);
    try {
      await widget.onSignIn!(email, pass, widget.role);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF2D66F6);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEEF3FF), Color(0xFFF2FAFF), Color(0xFFFFF6EC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.school_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Welcome text
                    const Text(
                      'Welcome Back',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to access your classroom management dashboard',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Login form
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFFFFF), Color(0xFFF8FBFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF2D66F6).withOpacity(0.12),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2D66F6).withOpacity(0.08),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email field
                          const _FieldLabel('Email Address'),
                          const SizedBox(height: 8),
                          _AppTextField(
                            controller: _email,
                            hintText: 'your.email@school.com',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),

                          // Password field
                          const _FieldLabel('Password'),
                          const SizedBox(height: 8),
                          _AppTextField(
                            controller: _password,
                            hintText: 'Enter your password',
                            obscureText: _obscure,
                            suffix: IconButton(
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                              ),
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Sign in button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _loading ? null : _handleSignIn,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBlue,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              child: Text(
                                _loading ? 'Signing in...' : 'Sign In',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Quick login options
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Access',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _QuickRoleButton(
                                text: 'Admin',
                                icon: Icons.admin_panel_settings_outlined,
                                selected: widget.role == UserRole.admin,
                                onTap: () => widget.onQuickRoleTap?.call(
                                  UserRole.admin,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _QuickRoleButton(
                                text: 'Teacher',
                                icon: Icons.person_outline,
                                selected: widget.role == UserRole.teacher,
                                onTap: () => widget.onQuickRoleTap?.call(
                                  UserRole.teacher,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _QuickRoleButton(
                                text: 'Student',
                                icon: Icons.school_outlined,
                                selected: widget.role == UserRole.student,
                                onTap: () => widget.onQuickRoleTap?.call(
                                  UserRole.student,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Footer
                    Text(
                      '© 2024 Smart Classroom IoT. All rights reserved.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: Colors.black.withOpacity(0.7),
      ),
    );
  }
}

class _AppTextField extends StatelessWidget {
  const _AppTextField({
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.suffix,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 13.5),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.25)),
        filled: true,
        fillColor: const Color(0xFFFFFFFF),
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: const Color(0xFF2D66F6).withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}

class _QuickRoleButton extends StatelessWidget {
  const _QuickRoleButton({
    required this.text,
    required this.icon,
    required this.onTap,
    required this.selected,
  });

  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  final bool selected;

  Color _roleColor() {
    switch (text) {
      case 'Admin':
        return const Color(0xFF2D66F6);
      case 'Teacher':
        return const Color(0xFF0EA5E9);
      default:
        return const Color(0xFFF97316);
    }
  }

  @override
  Widget build(BuildContext context) {
    final roleColor = _roleColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          gradient: selected
              ? LinearGradient(
                  colors: [roleColor, roleColor.withOpacity(0.78)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: selected ? null : Colors.white,
          border: Border.all(
            color: selected ? roleColor : roleColor.withOpacity(0.35),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: selected ? Colors.white : roleColor,
            ),
            const SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : roleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
