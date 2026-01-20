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
          gradient: RadialGradient(
            center: Alignment(-0.6, -0.8),
            radius: 1.3,
            colors: [Color(0xFFF4FAFF), Color(0xFFEFF6FF), Color(0xFFF7FBFF)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo box
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                            color: Colors.black.withOpacity(0.12),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Title / subtitle
                    const Text(
                      'Smart Classroom IoT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Intelligent classroom management system',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.55),
                      ),
                    ),
                    const SizedBox(height: 26),

                    // Card
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 26,
                            offset: const Offset(0, 14),
                            color: Colors.black.withOpacity(0.12),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _FieldLabel('Email Address'),
                          const SizedBox(height: 8),
                          _AppTextField(
                            controller: _email,
                            hintText: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),

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
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              color: Colors.black.withOpacity(0.45),
                            ),
                          ),
                          const SizedBox(height: 18),

                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton.icon(
                              onPressed: _loading ? null : _handleSignIn,
                              icon: const Icon(
                                Icons.verified_user_outlined,
                                size: 18,
                              ),
                              label: Text(
                                _loading ? 'Signing In...' : 'Sign In',
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBlue,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),
                          Text(
                            'Quick Login:',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.55),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),

                          Row(
                            children: [
                              Expanded(
                                child: _QuickRoleButton(
                                  text: 'Admin',
                                  selected: widget.role == UserRole.admin,
                                  onTap: () => widget.onQuickRoleTap?.call(
                                    UserRole.admin,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _QuickRoleButton(
                                  text: 'Teacher',
                                  selected: widget.role == UserRole.teacher,
                                  onTap: () => widget.onQuickRoleTap?.call(
                                    UserRole.teacher,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _QuickRoleButton(
                                  text: 'Student',
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
                    ),

                    const SizedBox(height: 22),
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
    required this.onTap,
    required this.selected,
  });

  final String text;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: Material(
        color: selected ? const Color(0xFFEAF1FF) : const Color(0xFFF3F6FA),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: selected
                    ? const Color(0xFF2D66F6)
                    : Colors.black.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
