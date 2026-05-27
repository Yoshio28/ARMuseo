// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:modelo_ar/screens/add_article.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _StatCard(
                label: 'Modelos',
                value: '12',
                icon: Icons.view_in_ar_rounded,
                color: AppTheme.accent,
              ),
              const SizedBox(width: 12),
              _StatCard(
                label: 'Favoritos',
                value: '5',
                icon: Icons.favorite_rounded,
                color: const Color(0xFFEC4899),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Text('Recientes',
              style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
          const SizedBox(height: 14),
          _ModelCard(
            name: 'Engranaje Helicoidal',
            category: 'Mecánica',
            scans: 14,
            color: AppTheme.accent,
            icon: Icons.settings_rounded,
          ),
          const SizedBox(height: 12),
          _ModelCard(
            name: 'Turbina de Viento',
            category: 'Energía',
            scans: 7,
            color: const Color(0xFF10B981),
            icon: Icons.wind_power_rounded,
          ),
          const SizedBox(height: 12),
          _ModelCard(
            name: 'Estructura Molecular',
            category: 'Química',
            scans: 22,
            color: const Color(0xFF7C3AED),
            icon: Icons.science_rounded,
          ),
          const SizedBox(height: 28),
          const Text('Acciones rápidas',
              style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
          const SizedBox(height: 14),
          Row(
            children: [
              _QuickAction(
                icon: Icons.add_rounded,
                label: 'Nuevo modelo',
                color: AppTheme.accent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddArticlePage(), 
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              _QuickAction(
                icon: Icons.cloud_upload_rounded,
                label: 'Subir',
                color: const Color(0xFF10B981),
                onTap: () {
                  // Acción para subir en el futuro
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 10),
            Text(value,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.w800, fontSize: 22)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                    color: AppTheme.textSecondary, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _ModelCard extends StatelessWidget {
  final String name;
  final String category;
  final int scans;
  final Color color;
  final IconData icon;

  const _ModelCard(
      {required this.name,
      required this.category,
      required this.scans,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                const SizedBox(height: 3),
                Text(category,
                    style: const TextStyle(
                        color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.qr_code_rounded,
                  color: color.withOpacity(0.7), size: 16),
              const SizedBox(height: 4),
              Text('$scans scans',
                  style: const TextStyle(
                      color: AppTheme.textSecondary, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction(
      {required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 8),
              Text(label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: color, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
          ),
        ),
      ),
    );
  }
}
