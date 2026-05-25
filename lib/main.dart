// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'theme/app_theme.dart';
import 'main_shell.dart';
import 'screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final userProvider = UserProvider();
  await userProvider.load();

  runApp(
    ChangeNotifierProvider.value(
      value: userProvider,
      child: const ModeloARApp(),
    ),
  );
}

class ModeloARApp extends StatelessWidget {
  const ModeloARApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modelo AR',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: Consumer<UserProvider>(
        builder: (_, user, __) {
          if (user.isLoggedIn) return const MainShell();
          return const LoginScreen();
        },
      ),
    );
  }
}
