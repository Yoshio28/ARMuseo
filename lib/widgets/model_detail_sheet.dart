// lib/widgets/model_detail_sheet.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ModelData {
  final String name;
  final String category;
  final IconData icon;
  final Color color;
  final String? price;
  final String description;
  final String format;
  final String size;
  final String polygons;
  final List<String> tags;

  const ModelData({
    required this.name,
    required this.category,
    required this.icon,
    required this.color,
    this.price,
    required this.description,
    required this.format,
    required this.size,
    required this.polygons,
    required this.tags,
  });
}

void showModelDetail(BuildContext context, ModelData model) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _ModelDetailSheet(model: model),
  );
}

class _ModelDetailSheet extends StatelessWidget {
  final ModelData model;
  const _ModelDetailSheet({required this.model});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;

    return Container(
      height: screenH * 0.82,
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Handle
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 4),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Preview
                  Container(
                    width: double.infinity,
                    height: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: model.color.withOpacity(0.08),
                      border: Border.all(color: model.color.withOpacity(0.18)),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Fondo
                        Positioned(
                          right: -20,
                          top: -20,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: model.color.withOpacity(0.06),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -10,
                          bottom: -10,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: model.color.withOpacity(0.06),
                            ),
                          ),
                        ),
                        // Ícono ppal
                        Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            color: model.color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: model.color.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Icon(model.icon, color: model.color, size: 44),
                        ),
                        // Badge 3D
                        Positioned(
                          top: 14,
                          right: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.background.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: model.color.withOpacity(0.3)),
                            ),
                            child: Text('3D',
                                style: TextStyle(
                                    color: model.color,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 11)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(model.name,
                                style: const TextStyle(
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 22,
                                    letterSpacing: -0.3)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: model.color,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(model.category,
                                    style: const TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 13)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (model.price != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: model.price == 'Gratis'
                                ? AppTheme.success.withOpacity(0.12)
                                : model.color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: model.price == 'Gratis'
                                  ? AppTheme.success.withOpacity(0.3)
                                  : model.color.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            model.price!,
                            style: TextStyle(
                                color: model.price == 'Gratis'
                                    ? AppTheme.success
                                    : model.color,
                                fontWeight: FontWeight.w800,
                                fontSize: 15),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),

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
                  const SizedBox(height: 28),

                  // Botón acción
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        model.price != null
                            ? Icons.shopping_cart_rounded
                            : Icons.view_in_ar_rounded,
                        size: 18,
                      ),
                      label: Text(
                        model.price != null
                            ? (model.price == 'Gratis'
                                ? 'Obtener gratis'
                                : 'Comprar ${model.price}')
                            : 'Abrir en AR',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: model.color,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isLast;

  const _SpecRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 10),
              Text(label,
                  style: const TextStyle(
                      color: AppTheme.textSecondary, fontSize: 13)),
              const Spacer(),
              Text(value,
                  style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13)),
            ],
          ),
        ),
        if (!isLast)
          const Divider(
              height: 1, color: AppTheme.border, indent: 16, endIndent: 16),
      ],
    );
  }
}
