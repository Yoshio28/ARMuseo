// lib/screens/models_screen.dart
import 'package:flutter/material.dart';
import '../models/ar_model.dart';
import '../theme/app_theme.dart';
import '../models/ar_view_screen.dart';

class ModelsScreen extends StatefulWidget {
  const ModelsScreen({super.key});

  @override
  State<ModelsScreen> createState() => _ModelsScreenState();
}

class _ModelsScreenState extends State<ModelsScreen> {
  String _search = '';

  // ── Colores e íconos por categoría ────────────────────────────────
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

  IconData _iconForCategory(String cat) {
    switch (cat.toLowerCase()) {
      case 'escultura':
        return Icons.account_balance_rounded;
      case 'anatomía':
        return Icons.biotech_rounded;
      case 'arte sacro':
        return Icons.church_rounded;
      case 'arte moderno':
        return Icons.palette_rounded;
      case 'arte antiguo':
        return Icons.museum_rounded;
      default:
        return Icons.view_in_ar_rounded;
    }
  }

  // ── Bottom sheet de detalle ───────────────────────────────────────
  void _showDetail(BuildContext context, ArModel model) {
    final color = _colorForCategory(model.category);
    final icon = _iconForCategory(model.category);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.82,
        decoration: const BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
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
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero visual
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: color.withOpacity(0.08),
                        border: Border.all(color: color.withOpacity(0.18)),
                      ),
                      child: Center(
                        child: Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Icon(icon, color: color, size: 44),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Nombre
                    Text(model.name,
                        style: const TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3)),
                    const SizedBox(height: 8),

                    // Categoría
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
                    const SizedBox(height: 18),

                    // Descripción
                    const Text('Descripción',
                        style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                    const SizedBox(height: 10),
                    Text(model.description,
                        style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 14,
                            height: 1.6)),
                    const SizedBox(height: 28),

                    // Botón "Ver en Realidad Aumentada"
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // cierra sheet
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ArViewScreen(model: model),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [color, color.withOpacity(0.7)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.35),
                                blurRadius: 18,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.view_in_ar_rounded,
                                  color: Colors.white, size: 22),
                              SizedBox(width: 10),
                              Text('Ver en Realidad Aumentada',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = kArModels
        .where((m) =>
            m.name.toLowerCase().contains(_search.toLowerCase()) ||
            m.category.toLowerCase().contains(_search.toLowerCase()))
        .toList();

    return Column(
      children: [
        // ── Buscador ──────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.border),
            ),
            child: Row(children: [
              const Icon(Icons.search_rounded,
                  color: AppTheme.textSecondary, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  onChanged: (v) => setState(() => _search = v),
                  style: const TextStyle(
                      color: AppTheme.textPrimary, fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'Buscar modelos...',
                    hintStyle:
                        TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 16),

        // ── Grid ──────────────────────────────────────────────────
        Expanded(
          child: filtered.isEmpty
              ? const Center(
                  child: Text('Sin resultados',
                      style: TextStyle(
                          color: AppTheme.textSecondary, fontSize: 14)))
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  itemCount: filtered.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.84,
                  ),
                  itemBuilder: (context, i) {
                    final model = filtered[i];
                    final color = _colorForCategory(model.category);
                    final icon = _iconForCategory(model.category);

                    return GestureDetector(
                      onTap: () => _showDetail(context, model),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceCard,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppTheme.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(18)),
                                  color: color.withOpacity(0.08),
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 56,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          color: color.withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child:
                                            Icon(icon, color: color, size: 28),
                                      ),
                                    ),
                                    // Badge AR
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: color.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: color.withOpacity(0.4)),
                                        ),
                                        child: Row(children: [
                                          Icon(Icons.view_in_ar_rounded,
                                              color: color, size: 11),
                                          const SizedBox(width: 3),
                                          Text('AR',
                                              style: TextStyle(
                                                  color: color,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700)),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(model.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: AppTheme.textPrimary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13)),
                                  const SizedBox(height: 6),
                                  Row(children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: color),
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(model.category,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: AppTheme.textSecondary,
                                              fontSize: 11)),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
