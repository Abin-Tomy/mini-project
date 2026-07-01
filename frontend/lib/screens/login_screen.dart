import 'dart:math';
import 'package:flutter/material.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  late AnimationController _bgAnimController;
  late AnimationController _entryController;
  late AnimationController _pulseController;
  late AnimationController _floatController;

  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _titleFade;
  late Animation<Offset> _cardSlide;
  late Animation<double> _cardFade;
  late Animation<double> _field1Fade;
  late Animation<double> _field2Fade;
  late Animation<double> _buttonFade;
  late Animation<double> _footerFade;
  late Animation<double> _pulseAnim;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();

    // Background particle drift
    _bgAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Staggered entry animations
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Logo pulse/glow
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    // Logo floating
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _logoFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    ));
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.35, curve: Curves.elasticOut),
    ));
    _titleFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.15, 0.4, curve: Curves.easeOut),
    ));
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.25, 0.55, curve: Curves.easeOutCubic),
    ));
    _cardFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.25, 0.5, curve: Curves.easeOut),
    ));
    _field1Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.35, 0.55, curve: Curves.easeOut),
    ));
    _field2Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.45, 0.65, curve: Curves.easeOut),
    ));
    _buttonFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.55, 0.75, curve: Curves.easeOut),
    ));
    _footerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.65, 0.85, curve: Curves.easeOut),
    ));

    _pulseAnim = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _floatAnim = Tween<double>(begin: -6.0, end: 6.0).animate(CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOut,
    ));

    _entryController.forward();
  }

  @override
  void dispose() {
    _bgAnimController.dispose();
    _entryController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- Color Palette ---
  static const _bgDark = Color(0xFF0D0D12);
  static const _bgCard = Color(0xFF1A1824);
  static const _accent = Color(0xFFD4893C);       // warm copper/amber
  static const _accentLight = Color(0xFFE8A55A);   // lighter amber
  static const _accentMuted = Color(0xFFC4785A);   // terracotta
  static const _textPrimary = Color(0xFFF5F0EB);   // warm off-white
  static const _textSecondary = Color(0xFF9B958E);  // warm gray
  static const _fieldBg = Color(0xFF14131A);
  static const _fieldBorder = Color(0xFF2A2835);
  static const _errorColor = Color(0xFFE85D5D);

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Login functionality coming soon!'),
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
          // --- Animated background particles ---
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

          // --- Subtle radial glow ---
          Positioned(
            top: -size.height * 0.15,
            right: -size.width * 0.3,
            child: Container(
              width: size.width * 0.9,
              height: size.width * 0.9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _accent.withAlpha(18),
                    _accent.withAlpha(5),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),

                      // --- Animated Logo ---
                      AnimatedBuilder(
                        animation: Listenable.merge([
                          _entryController,
                          _pulseController,
                          _floatController,
                        ]),
                        builder: (context, child) {
                          final glowAlpha =
                              (25 + (_pulseAnim.value * 35)).toInt();
                          return FadeTransition(
                            opacity: _logoFade,
                            child: Transform.translate(
                              offset: Offset(0, _floatAnim.value),
                              child: Transform.scale(
                                scale: _logoScale.value,
                                child: Container(
                                  width: 100,
                                  height: 100,
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
                                        color: _accent.withAlpha(glowAlpha),
                                        blurRadius: 40 +
                                            (_pulseAnim.value * 15),
                                        spreadRadius:
                                            4 + (_pulseAnim.value * 6),
                                      ),
                                    ],
                                  ),
                                  child: CustomPaint(
                                    painter: _HeartbeatLogoPainter(
                                      progress: _pulseAnim.value,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // --- App title ---
                      FadeTransition(
                        opacity: _titleFade,
                        child: Column(
                          children: [
                            const Text(
                              'HealthAI',
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                                color: _textPrimary,
                                letterSpacing: -0.8,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Your AI-Powered Health Assistant',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: _textSecondary,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 44),

                      // --- Login Card ---
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
                                  const Text(
                                    'Welcome Back',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: _textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Sign in to continue your health journey',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: _textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 30),

                                  // Email
                                  FadeTransition(
                                    opacity: _field1Fade,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildInputLabel('Email Address'),
                                        const SizedBox(height: 8),
                                        _buildTextField(
                                          controller: _emailController,
                                          hint: 'you@example.com',
                                          icon: Icons.alternate_email_rounded,
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

                                  const SizedBox(height: 20),

                                  // Password
                                  FadeTransition(
                                    opacity: _field2Fade,
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
                                              return 'Please enter your password';
                                            }
                                            if (value.length < 6) {
                                              return 'At least 6 characters';
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

                                  const SizedBox(height: 12),

                                  // Forgot password
                                  FadeTransition(
                                    opacity: _field2Fade,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(0, 0),
                                          tapTargetSize:
                                              MaterialTapTargetSize
                                                  .shrinkWrap,
                                        ),
                                        child: const Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            color: _accentLight,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 26),

                                  // Login button
                                  FadeTransition(
                                    opacity: _buttonFade,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 54,
                                      child: ElevatedButton(
                                        onPressed:
                                            _isLoading ? null : _handleLogin,
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
                                                'Sign In',
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

                      const SizedBox(height: 32),

                      // --- Register link ---
                      FadeTransition(
                        opacity: _footerFade,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: _textSecondary,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const RegisterScreen(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeInOut,
                                        ),
                                        child: SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0.05, 0),
                                            end: Offset.zero,
                                          ).animate(CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeOutCubic,
                                          )),
                                          child: child,
                                        ),
                                      );
                                    },
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign Up',
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

                      const SizedBox(height: 40),
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
    bool obscureText = false,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(color: _textPrimary, fontSize: 15),
      cursorColor: _accent,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: _textSecondary.withAlpha(120), fontSize: 15),
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
// Custom heartbeat/pulse logo painter
// ────────────────────────────────────────────
class _HeartbeatLogoPainter extends CustomPainter {
  final double progress;
  _HeartbeatLogoPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Draw a stylized cross/plus (medical)
    final crossPaint = Paint()
      ..color = Colors.white.withAlpha(230)
      ..style = PaintingStyle.fill;

    final crossWidth = size.width * 0.12;
    final crossLen = size.width * 0.32;

    // Vertical bar
    final vRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, cy), width: crossWidth, height: crossLen),
      const Radius.circular(3),
    );
    canvas.drawRRect(vRect, crossPaint);

    // Horizontal bar
    final hRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, cy), width: crossLen, height: crossWidth),
      const Radius.circular(3),
    );
    canvas.drawRRect(hRect, crossPaint);

    // Draw heartbeat line across the center
    final linePaint = Paint()
      ..color = Colors.white.withAlpha((140 + progress * 80).toInt())
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final lineY = cy + crossLen * 0.28;
    final left = cx - crossLen * 0.7;
    final right = cx + crossLen * 0.7;
    final mid = (left + right) / 2;

    path.moveTo(left, lineY);
    path.lineTo(mid - 10, lineY);
    // Heartbeat spike
    final spikeHeight = 8 + progress * 5;
    path.lineTo(mid - 5, lineY - spikeHeight);
    path.lineTo(mid, lineY + spikeHeight * 0.6);
    path.lineTo(mid + 5, lineY - spikeHeight * 0.4);
    path.lineTo(mid + 10, lineY);
    path.lineTo(right, lineY);

    canvas.drawPath(path, linePaint);

    // Small dot ring around logo (rotating)
    final dotPaint = Paint()
      ..color = Colors.white.withAlpha(60);
    for (int i = 0; i < 8; i++) {
      final angle = (i / 8) * 2 * pi + (progress * pi * 0.5);
      final radius = size.width * 0.44;
      final dx = cx + cos(angle) * radius;
      final dy = cy + sin(angle) * radius;
      canvas.drawCircle(Offset(dx, dy), 1.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _HeartbeatLogoPainter old) =>
      old.progress != progress;
}

// ────────────────────────────────────────────
// Floating ambient particles in the background
// ────────────────────────────────────────────
class _ParticlePainter extends CustomPainter {
  final double progress;
  final Color color;
  _ParticlePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(42); // Fixed seed for stable positions
    final paint = Paint();

    for (int i = 0; i < 35; i++) {
      final baseX = rng.nextDouble() * size.width;
      final baseY = rng.nextDouble() * size.height;
      final speed = 0.3 + rng.nextDouble() * 0.7;
      final radius = 1.0 + rng.nextDouble() * 2.0;
      final alpha = (10 + rng.nextInt(25)).toDouble();

      // Gentle drift
      final dx = baseX + sin((progress * 2 * pi * speed) + i) * 30;
      final dy = baseY + cos((progress * 2 * pi * speed * 0.7) + i) * 20;

      paint.color = color.withAlpha(alpha.toInt());
      canvas.drawCircle(Offset(dx % size.width, dy % size.height), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) =>
      old.progress != progress;
}
