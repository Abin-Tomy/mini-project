import 'dart:math';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool _acceptedTerms = false;

  late AnimationController _bgAnimController;
  late AnimationController _entryController;

  late Animation<double> _headerFade;
  late Animation<Offset> _cardSlide;
  late Animation<double> _cardFade;
  late Animation<double> _f1Fade;
  late Animation<double> _f2Fade;
  late Animation<double> _f3Fade;
  late Animation<double> _f4Fade;
  late Animation<double> _btnFade;
  late Animation<double> _footerFade;

  // --- Color Palette (matches login_screen) ---
  static const _bgDark = Color(0xFF0D0D12);
  static const _bgCard = Color(0xFF1A1824);
  static const _accent = Color(0xFFD4893C);
  static const _accentLight = Color(0xFFE8A55A);
  static const _accentMuted = Color(0xFFC4785A);
  static const _textPrimary = Color(0xFFF5F0EB);
  static const _textSecondary = Color(0xFF9B958E);
  static const _fieldBg = Color(0xFF14131A);
  static const _fieldBorder = Color(0xFF2A2835);
  static const _errorColor = Color(0xFFE85D5D);

  @override
  void initState() {
    super.initState();

    _bgAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.25, curve: Curves.easeOut),
    ));
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.1, 0.4, curve: Curves.easeOutCubic),
    ));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.1, 0.35, curve: Curves.easeOut),
    ));
    _f1Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.2, 0.38, curve: Curves.easeOut),
    ));
    _f2Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.28, 0.46, curve: Curves.easeOut),
    ));
    _f3Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.36, 0.54, curve: Curves.easeOut),
    ));
    _f4Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.44, 0.62, curve: Curves.easeOut),
    ));
    _btnFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.55, 0.73, curve: Curves.easeOut),
    ));
    _footerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.65, 0.82, curve: Curves.easeOut),
    ));

    _entryController.forward();
  }

  @override
  void dispose() {
    _bgAnimController.dispose();
    _entryController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      if (!_acceptedTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please accept the Terms & Conditions'),
            backgroundColor: _errorColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        return;
      }

      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Registration functionality coming soon!'),
              backgroundColor: _accent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _bgDark,
      body: Stack(
        children: [
          // --- Background particles ---
          AnimatedBuilder(
            animation: _bgAnimController,
            builder: (context, _) => CustomPaint(
              size: size,
              painter: _ParticlePainter(
                progress: _bgAnimController.value,
                color: _accent,
              ),
            ),
          ),

          // --- Radial glow (bottom-left for variety) ---
          Positioned(
            bottom: -size.height * 0.1,
            left: -size.width * 0.25,
            child: Container(
              width: size.width * 0.85,
              height: size.width * 0.85,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _accent.withAlpha(16),
                    _accent.withAlpha(4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // --- Main content ---
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),

                      // --- Header: back + title ---
                      FadeTransition(
                        opacity: _headerFade,
                        child: Column(
                          children: [
                            // Back button
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: _bgCard,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: _fieldBorder,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: _textPrimary,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),

                            // Small accent logo
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    _accentLight,
                                    _accent,
                                    _accentMuted,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: _accent.withAlpha(40),
                                    blurRadius: 24,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.person_add_alt_1_rounded,
                                size: 28,
                                color: Color(0xFF1A1008),
                              ),
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: _textPrimary,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Start your health journey with HealthAI',
                              style: TextStyle(
                                fontSize: 14,
                                color: _textSecondary,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // --- Register Card ---
                      SlideTransition(
                        position: _cardSlide,
                        child: FadeTransition(
                          opacity: _cardFade,
                          child: Container(
                            padding: const EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: _bgCard,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: _fieldBorder,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(60),
                                  blurRadius: 50,
                                  offset: const Offset(0, 24),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Full Name
                                  FadeTransition(
                                    opacity: _f1Fade,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildInputLabel('Full Name'),
                                        const SizedBox(height: 8),
                                        _buildTextField(
                                          controller: _nameController,
                                          hint: 'John Doe',
                                          icon: Icons.person_outline_rounded,
                                          keyboardType: TextInputType.name,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your name';
                                            }
                                            if (value.trim().split(' ').length <
                                                2) {
                                              return 'Enter first & last name';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 18),

                                  // Email
                                  FadeTransition(
                                    opacity: _f2Fade,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildInputLabel('Email Address'),
                                        const SizedBox(height: 8),
                                        _buildTextField(
                                          controller: _emailController,
                                          hint: 'you@example.com',
                                          icon:
                                              Icons.alternate_email_rounded,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your email';
                                            }
                                            if (!RegExp(
                                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                .hasMatch(value)) {
                                              return 'Enter a valid email';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 18),

                                  // Password
                                  FadeTransition(
                                    opacity: _f3Fade,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildInputLabel('Password'),
                                        const SizedBox(height: 8),
                                        _buildTextField(
                                          controller: _passwordController,
                                          hint: '••••••••',
                                          icon: Icons.lock_outline_rounded,
                                          obscureText: _obscurePassword,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter a password';
                                            }
                                            if (value.length < 8) {
                                              return 'At least 8 characters';
                                            }
                                            if (!RegExp(r'(?=.*[A-Z])')
                                                .hasMatch(value)) {
                                              return 'Need one uppercase letter';
                                            }
                                            if (!RegExp(r'(?=.*[0-9])')
                                                .hasMatch(value)) {
                                              return 'Need one number';
                                            }
                                            return null;
                                          },
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons
                                                      .visibility_outlined,
                                              color: _textSecondary,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword =
                                                    !_obscurePassword;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 18),

                                  // Confirm Password
                                  FadeTransition(
                                    opacity: _f4Fade,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildInputLabel('Confirm Password'),
                                        const SizedBox(height: 8),
                                        _buildTextField(
                                          controller:
                                              _confirmPasswordController,
                                          hint: '••••••••',
                                          icon: Icons.lock_outline_rounded,
                                          obscureText:
                                              _obscureConfirmPassword,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Confirm your password';
                                            }
                                            if (value !=
                                                _passwordController.text) {
                                              return 'Passwords do not match';
                                            }
                                            return null;
                                          },
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscureConfirmPassword
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons
                                                      .visibility_outlined,
                                              color: _textSecondary,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscureConfirmPassword =
                                                    !_obscureConfirmPassword;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Terms checkbox
                                  FadeTransition(
                                    opacity: _btnFade,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: Checkbox(
                                            value: _acceptedTerms,
                                            onChanged: (value) {
                                              setState(() {
                                                _acceptedTerms =
                                                    value ?? false;
                                              });
                                            },
                                            activeColor: _accent,
                                            checkColor:
                                                const Color(0xFF1A1008),
                                            side: const BorderSide(
                                              color: _textSecondary,
                                              width: 1.5,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _acceptedTerms =
                                                    !_acceptedTerms;
                                              });
                                            },
                                            child: RichText(
                                              text: const TextSpan(
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: _textSecondary,
                                                  height: 1.4,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          'I agree to the '),
                                                  TextSpan(
                                                    text: 'Terms of Service',
                                                    style: TextStyle(
                                                      color: _accentLight,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(text: ' and '),
                                                  TextSpan(
                                                    text: 'Privacy Policy',
                                                    style: TextStyle(
                                                      color: _accentLight,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 26),

                                  // Register button
                                  FadeTransition(
                                    opacity: _btnFade,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 54,
                                      child: ElevatedButton(
                                        onPressed: _isLoading
                                            ? null
                                            : _handleRegister,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: _accent,
                                          foregroundColor:
                                              const Color(0xFF1A1008),
                                          disabledBackgroundColor:
                                              _accent.withAlpha(120),
                                          elevation: 0,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: _isLoading
                                            ? const SizedBox(
                                                width: 22,
                                                height: 22,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Color(0xFF1A1008),
                                                  strokeWidth: 2.5,
                                                ),
                                              )
                                            : const Text(
                                                'Create Account',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.3,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // --- Login link ---
                      FadeTransition(
                        opacity: _footerFade,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: _textSecondary,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: _accentLight,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: _textSecondary,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool obscureText = false,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(color: _textPrimary, fontSize: 15),
      cursorColor: _accent,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            TextStyle(color: _textSecondary.withAlpha(120), fontSize: 15),
        prefixIcon: Icon(icon, color: _textSecondary, size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: _fieldBg,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _fieldBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _fieldBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _accent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _errorColor, width: 1.5),
        ),
        errorStyle: const TextStyle(color: _errorColor, fontSize: 12),
      ),
    );
  }
}

// ────────────────────────────────────────────
// Same particle background as login (shared)
// ────────────────────────────────────────────
class _ParticlePainter extends CustomPainter {
  final double progress;
  final Color color;
  _ParticlePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(77); // Different seed than login
    final paint = Paint();

    for (int i = 0; i < 30; i++) {
      final baseX = rng.nextDouble() * size.width;
      final baseY = rng.nextDouble() * size.height;
      final speed = 0.3 + rng.nextDouble() * 0.7;
      final radius = 1.0 + rng.nextDouble() * 2.0;
      final alpha = (8 + rng.nextInt(22)).toDouble();

      final dx = baseX + sin((progress * 2 * pi * speed) + i) * 25;
      final dy = baseY + cos((progress * 2 * pi * speed * 0.7) + i) * 18;

      paint.color = color.withAlpha(alpha.toInt());
      canvas.drawCircle(
          Offset(dx % size.width, dy % size.height), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) =>
      old.progress != progress;
}
