// lib/providers/user_provider.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  // ── Datos persistidos ──────────────────────────────────────────
  String _name = '';
  String _email = '';
  String _phone = '';
  String _avatarPath = '';   // ruta local a la foto elegida
  bool _notificationsEnabled = true;
  bool _isLoggedIn = false;

  // ── Getters ───────────────────────────────────────────────────
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get avatarPath => _avatarPath;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get isLoggedIn => _isLoggedIn;

  File? get avatarFile =>
      _avatarPath.isNotEmpty ? File(_avatarPath) : null;

  String get initials {
    final parts = _name.trim().split(' ');
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return _name.isNotEmpty ? _name[0].toUpperCase() : 'U';
  }

  // ── Claves SharedPreferences ──────────────────────────────────
  static const _kName          = 'user_name';
  static const _kEmail         = 'user_email';
  static const _kPhone         = 'user_phone';
  static const _kAvatar        = 'user_avatar';
  static const _kNotifs        = 'user_notifs';
  static const _kLoggedIn      = 'user_logged_in';

  // ── Carga inicial desde disco ─────────────────────────────────
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _name       = prefs.getString(_kName)  ?? '';
    _email      = prefs.getString(_kEmail) ?? '';
    _phone      = prefs.getString(_kPhone) ?? '';
    _avatarPath = prefs.getString(_kAvatar) ?? '';
    _notificationsEnabled = prefs.getBool(_kNotifs) ?? true;
    _isLoggedIn = prefs.getBool(_kLoggedIn) ?? false;
    notifyListeners();
  }

  // ── Persistir todo ────────────────────────────────────────────
  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kName,   _name);
    await prefs.setString(_kEmail,  _email);
    await prefs.setString(_kPhone,  _phone);
    await prefs.setString(_kAvatar, _avatarPath);
    await prefs.setBool(_kNotifs,   _notificationsEnabled);
    await prefs.setBool(_kLoggedIn, _isLoggedIn);
  }

  // ── Acciones ──────────────────────────────────────────────────
  Future<void> login({
    required String name,
    required String email,
    String phone = '',
    String avatarPath = '',
  }) async {
    _name       = name;
    _email      = email;
    _phone      = phone;
    _avatarPath = avatarPath;
    _isLoggedIn = true;
    notifyListeners();
    await _save();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kLoggedIn, false);
  }

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

  Future<void> updateAvatar(String path) async {
    _avatarPath = path;
    notifyListeners();
    await _save();
  }

  Future<void> setNotifications(bool value) async {
    _notificationsEnabled = value;
    notifyListeners();
    await _save();
  }
}
