// lib/main.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'theme/app_theme.dart';
import 'main_shell.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Carga UserProvider desde SharedPreferences antes de pintar UI
  final userProvider = UserProvider();
  await userProvider.load();

  // Si hay sesión Firebase activa, sincroniza datos al UserProvider
  final firebaseUser = FirebaseAuth.instance.currentUser;
  if (firebaseUser != null && !userProvider.isLoggedIn) {
    await userProvider.login(
      name: firebaseUser.displayName ?? firebaseUser.email!.split('@')[0],
      email: firebaseUser.email ?? '',
      avatarPath: firebaseUser.photoURL ?? '',
    );
  }

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
      // StreamBuilder escucha cambios de sesión Firebase en tiempo real.
      // Si el usuario cierra sesión desde otro dispositivo o expira el token,
      // la app reacciona automáticamente.
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Mientras Firebase resuelve el estado inicial
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const _SplashScreen();
          }

          final firebaseUser = snapshot.data;

          if (firebaseUser != null) {
            // Sesión Firebase activa → sincronizar UserProvider si es necesario
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              final provider = context.read<UserProvider>();
              if (!provider.isLoggedIn) {
                await provider.login(
                  name: firebaseUser.displayName ??
                      firebaseUser.email!.split('@')[0],
                  email: firebaseUser.email ?? '',
                  avatarPath: firebaseUser.photoURL ?? '',
                );
              }
            });
            return const MainShell();
          }

          // Sin sesión → pantalla de login personalizada
          return const LoginScreen();
        },
      ),
      routes: {
        '/main':    (context) => const MainShell(),
        '/sign-in': (context) => const LoginScreen(),
      },
    );
  }
}

// ── Splash mientras Firebase resuelve authStateChanges ─────────────────
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  colors: [AppTheme.accent, AppTheme.accentSecondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.accent.withOpacity(0.4),
                    blurRadius: 24, spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.view_in_ar_rounded,
                  color: Colors.white, size: 38),
            ),
            const SizedBox(height: 28),
            const SizedBox(
              width: 24, height: 24,
              child: CircularProgressIndicator(
                color: AppTheme.accent, strokeWidth: 2.5),
            ),
          ],
        ),
      ),
    );
  }
}
