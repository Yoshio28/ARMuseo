// lib/main.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'theme/app_theme.dart';
import 'main_shell.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider, AuthProvider;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ModeloARApp());
}

class ModeloARApp extends StatelessWidget {
  const ModeloARApp({super.key});

  List<AuthStateChangeAction> _authActions() {
    return [
      AuthStateChangeAction<UserCreated>((context, state) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user?.email != null) {
          await FirebaseFirestore.instance.collection('usuarios').doc(user!.uid).set({
            'email': user.email!,
            'activo': true,
            'fechaCreacion': FieldValue.serverTimestamp(),
          });
        }
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/main');
        }
      }),
      AuthStateChangeAction<SignedIn>((context, state) {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/main');
        }
      }),
    ];
  }

  Widget _buildSignInScreen(List<AuthProvider> providers) {
    return SignInScreen(
      providers: providers,
      actions: _authActions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];
    final currentUser = FirebaseAuth.instance.currentUser;

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider()..load())],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppTheme.background,
        ),
        home: currentUser != null ? const MainShell() : _buildSignInScreen(providers),
        routes: {
          '/main': (context) => const MainShell(),
          '/sign-in': (context) => _buildSignInScreen(providers),
        },
      ),
    );
  }
}

