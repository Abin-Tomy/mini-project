import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Immersive dark status bar matching the charcoal background
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0D0D12),
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(const HealthAIApp());
}

class HealthAIApp extends StatelessWidget {
  const HealthAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D12),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4893C),
          brightness: Brightness.dark,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
