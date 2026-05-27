// lib/screens/ar_view_screen.dart
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../models/ar_model.dart';
import '../theme/app_theme.dart';

class ArViewScreen extends StatelessWidget {
  final ArModel model;
  const ArViewScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final color = _colorForCategory(model.category);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.border),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppTheme.textPrimary, size: 18),
          ),
        ),
        title: Text(model.name,
            style: const TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 17)),
      ),
      body: Column(
        children: [
          // ── Visor 3D / AR ─────────────────────────────────────────
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              decoration: BoxDecoration(
                color: AppTheme.surfaceCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.border),
              ),
              clipBehavior: Clip.hardEdge,
              child: ModelViewer(
                src: model.glbPath, // ruta al .glb en assets/
                alt: model.name,
                ar: true, // activa el botón AR nativo
                autoRotate: true,
                cameraControls: true,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),

          // ── Info del modelo ───────────────────────────────────────
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre + categoría
                  Text(model.name,
                      style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3)),
                  const SizedBox(height: 8),
                  Row(children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: color),
                    ),
                    const SizedBox(width: 8),
                    Text(model.category,
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 13)),
                  ]),
                  const SizedBox(height: 16),

                  // Descripción
                  const Text('Descripción',
                      style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 15)),
                  const SizedBox(height: 8),
                  Text(model.description,
                      style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 13,
                          height: 1.6)),
                  const SizedBox(height: 20),

                  // Hint AR
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: color.withOpacity(0.25)),
                    ),
                    child: Row(children: [
                      Icon(Icons.view_in_ar_rounded, color: color, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Toca el botón AR en el visor para ver el modelo en tu entorno real.',
                          style: TextStyle(
                              color: color,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _colorForCategory(String cat) {
    switch (cat.toLowerCase()) {
      case 'escultura':
        return const Color(0xFF00D4FF);
      case 'anatomía':
        return const Color(0xFF10B981);
      case 'arte sacro':
        return const Color(0xFF7C3AED);
      case 'arte moderno':
        return const Color(0xFFEC4899);
      case 'arte antiguo':
        return const Color(0xFFF59E0B);
      default:
        return AppTheme.accent;
    }
  }
}
