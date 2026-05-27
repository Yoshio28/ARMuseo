// lib/providers/user_provider.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  // ── Instancias de Auth ────────────────────────────────────────────
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  // ── Datos en memoria ──────────────────────────────────────────────
  String _name = '';
  String _email = '';
  String _phone = '';
  String _avatarPath = '';
  bool _notificationsEnabled = true;
  bool _isLoggedIn = false;

  // ── Getters ───────────────────────────────────────────────────────
  String get name  => _name;
  String get email => _email;
  String get phone => _phone;
  String get avatarPath => _avatarPath;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get isLoggedIn => _isLoggedIn;

  bool get hasLocalAvatar =>
      _avatarPath.isNotEmpty && !_avatarPath.startsWith('http');

  File? get avatarFile => hasLocalAvatar ? File(_avatarPath) : null;

  String get avatarUrl =>
      _avatarPath.startsWith('http') ? _avatarPath : '';

  String get initials {
    final parts = _name.trim().split(' ');
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return _name.isNotEmpty ? _name[0].toUpperCase() : 'U';
  }

  // ── Claves SharedPreferences ──────────────────────────────────────
  static const _kName     = 'user_name';
  static const _kEmail    = 'user_email';
  static const _kPhone    = 'user_phone';
  static const _kAvatar   = 'user_avatar';
  static const _kNotifs   = 'user_notifs';
  static const _kLoggedIn = 'user_logged_in';

  // ── Carga inicial — FIX: envuelto en try/catch ────────────────────
  // El PlatformException "Unable to establish connection on channel:
  // dev.flutter.pigeon.shared_preferences_android.SharedPreferencesApi.getAll"
  // ocurre cuando:
  //   1. La app se ejecuta en un emulador/dispositivo con API < 23 (la nueva
  //      implementación Pigeon de shared_preferences ≥2.3.x requiere API 23+).
  //   2. El plugin no está inicializado antes del primer uso (race condition
  //      si se llama load() antes de WidgetsFlutterBinding.ensureInitialized()).
  //   3. Una caché de build corrupta que mezcla versiones antiguas y nuevas del
  //      plugin nativo.
  //
  // SOLUCIÓN aplicada aquí:
  //   • Llamar SharedPreferences.getInstance() dentro de un try/catch y caer
  //     a valores por defecto si falla, para no crashear la app.
  //   • En main.dart asegúrate de que WidgetsFlutterBinding.ensureInitialized()
  //     se llame ANTES de await userProvider.load().
  //   • Si el problema persiste, ejecuta:
  //       flutter clean && flutter pub get
  //     y en Android Studio: Build → Clean Project → Rebuild.
  //   • Si usas API < 23, baja shared_preferences a ^2.2.3 en pubspec.yaml
  //     (ya la tienes en esa versión, que es compatible; verifica que no haya
  //     una versión transitiva más nueva forzada por otro plugin con
  //     `flutter pub deps`).
  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _name       = prefs.getString(_kName)   ?? '';
      _email      = prefs.getString(_kEmail)  ?? '';
      _phone      = prefs.getString(_kPhone)  ?? '';
      _avatarPath = prefs.getString(_kAvatar) ?? '';
      _notificationsEnabled = prefs.getBool(_kNotifs)   ?? true;
      _isLoggedIn           = prefs.getBool(_kLoggedIn) ?? false;
    } catch (e) {
      // Si SharedPreferences falla (emulador antiguo, plugin no inicializado,
      // etc.) continuamos con valores por defecto en memoria.
      debugPrint('[UserProvider] SharedPreferences.load falló: $e');
      // Valores por defecto ya asignados en las declaraciones de campo.
    }
    notifyListeners();
  }

  // ── Persistir todo — FIX: mismo guard try/catch ───────────────────
  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kName,   _name);
      await prefs.setString(_kEmail,  _email);
      await prefs.setString(_kPhone,  _phone);
      await prefs.setString(_kAvatar, _avatarPath);
      await prefs.setBool(_kNotifs,   _notificationsEnabled);
      await prefs.setBool(_kLoggedIn, _isLoggedIn);
    } catch (e) {
      debugPrint('[UserProvider] SharedPreferences.save falló: $e');
    }
  }

  // ── Login ─────────────────────────────────────────────────────────
  Future<void> login({
    required String name,
    required String email,
    String phone = '',
    String avatarPath = '',
  }) async {
    _name       = name;
    _email      = email;
    _phone      = phone;
    if (avatarPath.isNotEmpty) _avatarPath = avatarPath;
    _isLoggedIn = true;
    notifyListeners();
    await _save();
  }

  // ── Logout ────────────────────────────────────────────────────────
  Future<void> logout() async {
    _isLoggedIn = false;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_kLoggedIn, false);
    } catch (e) {
      debugPrint('[UserProvider] SharedPreferences.logout falló: $e');
    }

    try { await _firebaseAuth.signOut(); } catch (_) {}

    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
    } catch (_) {}
  }

  // ── Actualizar perfil ─────────────────────────────────────────────
  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
  }) async {
    if (name  != null && name.trim().isNotEmpty)  _name  = name.trim();
    if (email != null && email.trim().isNotEmpty) _email = email.trim();
    if (phone != null && phone.trim().isNotEmpty) _phone = phone.trim();
    notifyListeners();
    await _save();
  }

  // ── Actualizar avatar ─────────────────────────────────────────────
  Future<void> updateAvatar(String path) async {
    _avatarPath = path;
    notifyListeners();
    await _save();
  }

  // ── Notificaciones ────────────────────────────────────────────────
  Future<void> setNotifications(bool value) async {
    _notificationsEnabled = value;
    notifyListeners();
    await _save();
  }
}
