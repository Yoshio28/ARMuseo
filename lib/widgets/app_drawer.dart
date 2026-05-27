// lib/widgets/app_drawer.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onNavigate;

  const AppDrawer({
    super.key,
    required this.currentIndex,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 285,
      backgroundColor: AppTheme.surface,
      child: Column(
        children: [
          // Header sincronizado
          _DrawerHeader(),
          const SizedBox(height: 8),

          _DrawerItem(
            icon: Icons.home_rounded,
            label: 'Inicio',
            isActive: currentIndex == 0,
            onTap: () => onNavigate(0),
          ),
          _DrawerItem(
            icon: Icons.view_in_ar_rounded,
            label: 'Mis Modelos',
            isActive: currentIndex == 1,
            onTap: () => onNavigate(1),
          ),
          _DrawerItem(
            icon: Icons.qr_code_scanner_rounded,
            label: 'Escanear QR',
            isActive: currentIndex == 2,
            onTap: () => onNavigate(2),
          ),
          _DrawerItem(
            icon: Icons.store_rounded,
            label: 'Tienda',
            isActive: currentIndex == 3,
            onTap: () => onNavigate(3),
          ),
          _DrawerItem(
            icon: Icons.person_rounded,
            label: 'Perfil',
            isActive: currentIndex == 4,
            onTap: () => onNavigate(4),
          ),

          const Spacer(),

          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 28),
            child: Consumer<UserProvider>(
              builder: (_, user, __) => GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
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
                  if (confirm == true) {
                    await user.logout();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFF7F1D1D)),
                    color: const Color(0xFF7F1D1D).withOpacity(0.1),
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
                              fontWeight: FontWeight.w700,
                              fontSize: 14)),
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
}

class _DrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, user, __) => Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).padding.top + 20, 20, 24),
        decoration: const BoxDecoration(
          color: AppTheme.navBarBg,
          border: Border(bottom: BorderSide(color: AppTheme.border)),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: user.avatarFile == null
                    ? const LinearGradient(
                        colors: [AppTheme.accent, AppTheme.accentSecondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.accent.withOpacity(0.35),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: user.avatarFile != null
                  ? ClipOval(
                      child: Image.file(user.avatarFile!,
                          fit: BoxFit.cover, width: 52, height: 52))
                  : Center(
                      child: Text(
                        user.initials,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18),
                      ),
                    ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name.isEmpty ? 'Usuario' : user.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    user.email.isEmpty ? '' : user.email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppTheme.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: isActive ? AppTheme.accent.withOpacity(0.1) : Colors.transparent,
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          onTap();
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: isActive
                ? AppTheme.accent.withOpacity(0.2)
                : AppTheme.border.withOpacity(0.6),
          ),
          child: Icon(icon,
              color: isActive ? AppTheme.accent : AppTheme.textSecondary,
              size: 20),
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isActive ? AppTheme.accent : AppTheme.textPrimary,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
        trailing: isActive
            ? Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.accent,
                ),
              )
            : null,
      ),
    );
  }
}
