// lib/screens/profile_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceCard,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: AppTheme.border,
                  borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading:
                  const Icon(Icons.camera_alt_rounded, color: AppTheme.accent),
              title: const Text('Tomar foto',
                  style: TextStyle(color: AppTheme.textPrimary)),
              onTap: () async {
                Navigator.pop(ctx);
                final XFile? photo = await _picker.pickImage(
                    source: ImageSource.camera, imageQuality: 85);
                if (photo != null && mounted) {
                  await context.read<UserProvider>().updateAvatar(photo.path);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded,
                  color: AppTheme.accent),
              title: const Text('Elegir de galería',
                  style: TextStyle(color: AppTheme.textPrimary)),
              onTap: () async {
                Navigator.pop(ctx);
                final XFile? photo = await _picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 85);
                if (photo != null && mounted) {
                  await context.read<UserProvider>().updateAvatar(photo.path);
                }
              },
            ),
            Consumer<UserProvider>(
              builder: (_, user, __) => user.avatarPath.isNotEmpty
                  ? ListTile(
                      leading: const Icon(Icons.delete_outline_rounded,
                          color: Color(0xFFFCA5A5)),
                      title: const Text('Eliminar foto',
                          style: TextStyle(color: Color(0xFFFCA5A5))),
                      onTap: () {
                        Navigator.pop(ctx);
                        context.read<UserProvider>().updateAvatar('');
                      },
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _openEditProfile() {
    final user = context.read<UserProvider>();
    final nameCtrl = TextEditingController(text: user.name);
    final emailCtrl = TextEditingController(text: user.email);
    final phoneCtrl = TextEditingController(text: user.phone);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surfaceCard,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: AppTheme.border,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Editar perfil',
                  style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 20)),
              const SizedBox(height: 24),
              _EditField(
                  controller: nameCtrl,
                  label: 'Nombre de usuario',
                  icon: Icons.person_outline_rounded),
              const SizedBox(height: 14),
              _EditField(
                  controller: emailCtrl,
                  label: 'Correo electrónico',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 14),
              _EditField(
                  controller: phoneCtrl,
                  label: 'Celular',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await context.read<UserProvider>().updateProfile(
                          name: nameCtrl.text,
                          email: emailCtrl.text,
                          phone: phoneCtrl.text,
                        );
                    if (ctx.mounted) Navigator.pop(ctx);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Perfil actualizado'),
                          backgroundColor: AppTheme.success,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Guardar cambios',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openNotifications() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceCard,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Consumer<UserProvider>(
        builder: (_, user, __) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: AppTheme.border,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Notificaciones',
                  style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 20)),
              const SizedBox(height: 24),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppTheme.border),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Activar notificaciones',
                      style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  subtitle: Text(
                    user.notificationsEnabled
                        ? 'Habilitadas'
                        : 'Deshabilitadas',
                    style: TextStyle(
                        color: user.notificationsEnabled
                            ? AppTheme.success
                            : AppTheme.textSecondary,
                        fontSize: 12),
                  ),
                  value: user.notificationsEnabled,
                  activeColor: AppTheme.accent,
                  onChanged: (val) =>
                      context.read<UserProvider>().setNotifications(val),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cerrar',
                      style: TextStyle(color: AppTheme.textSecondary)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, user, __) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          children: [
            // header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFF00D4FF18), Color(0xFF7C3AED18)]),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                children: [
                  // Avatar
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: user.avatarFile == null
                                ? const LinearGradient(
                                    colors: [
                                        AppTheme.accent,
                                        AppTheme.accentSecondary
                                      ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)
                                : null,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.accent.withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: user.avatarFile != null
                              ? ClipOval(
                                  child: Image.file(user.avatarFile!,
                                      fit: BoxFit.cover, width: 84, height: 84))
                              : Center(
                                  child: Text(user.initials,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 28))),
                        ),
                      ),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.accent,
                            border:
                                Border.all(color: AppTheme.surface, width: 2),
                          ),
                          child: const Icon(Icons.camera_alt_rounded,
                              color: Colors.black, size: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(user.name.isEmpty ? 'Sin nombre' : user.name,
                      style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w800,
                          fontSize: 22)),
                  const SizedBox(height: 4),
                  if (user.email.isNotEmpty)
                    Text(user.email,
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 13)),
                  if (user.phone.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(user.phone,
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 13)),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ProfileStat(value: '12', label: 'Modelos'),
                      _divider(),
                      _ProfileStat(value: '5', label: 'Favoritos'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _SectionTitle('Cuenta'),
            _SettingsItem(
              icon: Icons.edit_outlined,
              label: 'Editar perfil',
              onTap: _openEditProfile,
            ),
            _SettingsItem(
              icon: Icons.notifications_outlined,
              label: 'Notificaciones',
              onTap: _openNotifications,
              trailing: Switch(
                value: user.notificationsEnabled,
                activeColor: AppTheme.accent,
                onChanged: (val) =>
                    context.read<UserProvider>().setNotifications(val),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),

            const SizedBox(height: 16),
            _SectionTitle('Preferencias'),
            _SettingsItem(
              icon: Icons.dark_mode_outlined,
              label: 'Tema de la aplicación',
              onTap: () {},
            ),

            const SizedBox(height: 16),
            _SectionTitle('Soporte'),
            _SettingsItem(
              icon: Icons.help_outline_rounded,
              label: 'Centro de ayuda',
              onTap: () {},
            ),

            const SizedBox(height: 24),

            GestureDetector(
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppTheme.surfaceCard,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    title: const Text('Cerrar sesión',
                        style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w700)),
                    content: const Text(
                        '¿Estás seguro de que deseas cerrar sesión?',
                        style: TextStyle(color: AppTheme.textSecondary)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancelar',
                            style: TextStyle(color: AppTheme.textSecondary)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Cerrar sesión',
                            style: TextStyle(
                                color: Color(0xFFFCA5A5),
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                );
                if (confirm == true && mounted) {
                  await context.read<UserProvider>().logout();
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF7F1D1D)),
                  color: const Color(0xFF7F1D1D).withOpacity(0.08),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_rounded,
                        color: Color(0xFFFCA5A5), size: 18),
                    SizedBox(width: 10),
                    Text('Cerrar sesión',
                        style: TextStyle(
                            color: Color(0xFFFCA5A5),
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(
      width: 1,
      height: 28,
      color: AppTheme.border,
      margin: const EdgeInsets.symmetric(horizontal: 20));
}

// Widgets aux

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;
  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(value,
              style: const TextStyle(
                  color: AppTheme.accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 22)),
          const SizedBox(height: 2),
          Text(label,
              style:
                  const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
        ],
      );
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(title,
              style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8)),
        ),
      );
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;

  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 2),
        child: ListTile(
          onTap: onTap,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          tileColor: AppTheme.surfaceCard,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          leading: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.border,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.textSecondary, size: 18),
          ),
          title: Text(label,
              style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          trailing: trailing ??
              const Icon(Icons.chevron_right_rounded,
                  color: AppTheme.textSecondary, size: 18),
        ),
      );
}

class _EditField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;

  const _EditField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.border),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14),
              decoration: InputDecoration(
                prefixIcon: Icon(icon, color: AppTheme.accent, size: 18),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
          ),
        ],
      );
}
