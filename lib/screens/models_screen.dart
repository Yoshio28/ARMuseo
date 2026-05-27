// lib/screens/models_screen.dart
import 'package:flutter/material.dart';
import 'package:modelo_ar/models/articulos.dart';
import 'package:modelo_ar/services/database_service.dart';
import '../theme/app_theme.dart';
import '../widgets/model_detail_sheet.dart';

class ModelsScreen extends StatefulWidget {
  const ModelsScreen({super.key});

  @override
  State<ModelsScreen> createState() => _ModelsScreenState();
}

class _ModelsScreenState extends State<ModelsScreen> {
  /*final List<ModelData> _models = const [
    ModelData(
      name: 'Engranaje Helicoidal',
      category: 'Mecánica',
      icon: Icons.settings_rounded,
      color: Color(0xFF00D4FF),
      description:
          'Modelo 3D de alta precisión de un engranaje helicoidal utilizado en transmisiones mecánicas. Incluye geometría detallada con dientes helicoidales y materiales texturizados.',
      format: 'GLTF / GLB',
      size: '4.2 MB',
      polygons: '18,400',
      tags: ['mecánica', 'engranaje', 'transmisión', 'industrial'],
    ),
    ModelData(
      name: 'Turbina de Viento',
      category: 'Energía',
      icon: Icons.wind_power_rounded,
      color: Color(0xFF10B981),
      description:
          'Representación tridimensional de una turbina eólica de eje horizontal. Ideal para proyectos educativos sobre energías renovables y generación eléctrica.',
      format: 'OBJ / MTL',
      size: '6.8 MB',
      polygons: '24,200',
      tags: ['energía', 'renovable', 'viento', 'eólica'],
    ),
    ModelData(
      name: 'Estructura Molecular',
      category: 'Química',
      icon: Icons.science_rounded,
      color: Color(0xFF7C3AED),
      description:
          'Modelo 3D de una estructura molecular orgánica compleja. Los átomos y enlaces están representados con sus proporciones reales para uso en clases de química.',
      format: 'GLTF / GLB',
      size: '2.1 MB',
      polygons: '8,600',
      tags: ['química', 'molécula', 'átomo', 'educación'],
    ),
    ModelData(
      name: 'ADN Helix',
      category: 'Biología',
      icon: Icons.biotech_rounded,
      color: Color(0xFFEC4899),
      description:
          'Doble hélice de ADN con representación fiel de los pares de bases nitrogenadas. Modelo optimizado para visualización en realidad aumentada.',
      format: 'GLTF / GLB',
      size: '3.5 MB',
      polygons: '12,800',
      tags: ['biología', 'ADN', 'genética', 'célula'],
    ),
    ModelData(
      name: 'Motor Eléctrico',
      category: 'Mecánica',
      icon: Icons.electric_bolt_rounded,
      color: Color(0xFFF59E0B),
      description:
          'Motor eléctrico de corriente alterna con estator, rotor y carcasa completos. Modelo seccionado para visualizar el interior y su funcionamiento.',
      format: 'FBX',
      size: '9.3 MB',
      polygons: '31,500',
      tags: ['motor', 'eléctrico', 'mecánica', 'física'],
    ),
    ModelData(
      name: 'Átomo de Carbono',
      category: 'Química',
      icon: Icons.bubble_chart_rounded,
      color: Color(0xFF7C3AED),
      description:
          'Representación esquemática del átomo de carbono con sus 6 protones, 6 neutrones y 6 electrones distribuidos en sus órbitas correspondientes.',
      format: 'GLTF / GLB',
      size: '1.4 MB',
      polygons: '5,200',
      tags: ['química', 'átomo', 'carbono', 'física'],
    ),
  ];*/

  Color _colorForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'mecánica':
      case 'mecanica':
        return const Color(0xFF00D4FF);
      case 'energía':
      case 'energia':
        return const Color(0xFF10B981);
      case 'química':
      case 'quimica':
        return const Color(0xFF7C3AED);
      case 'biología':
      case 'biologia':
        return const Color(0xFFEC4899);
      default:
        return AppTheme.accent;
    }
  }

  IconData _iconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'mecánica':
      case 'mecanica':
        return Icons.settings_rounded;
      case 'energía':
      case 'energia':
        return Icons.wind_power_rounded;
      case 'química':
      case 'quimica':
        return Icons.science_rounded;
      case 'biología':
      case 'biologia':
        return Icons.biotech_rounded;
      default:
        return Icons.article_rounded;
    }
  }

  void _showArticuloDetail(BuildContext context, Articulos articulo) {
    final color = _colorForCategory(articulo.categoria);
    final icon = _iconForCategory(articulo.categoria);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
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
                      Text(articulo.articulo,
                          style: const TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(articulo.categoria,
                              style: const TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Text('Historia',
                          style: TextStyle(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 16)),
                      const SizedBox(height: 10),
                      Text(articulo.historia,
                          style: const TextStyle(
                              color: AppTheme.textSecondary, fontSize: 14)),
                      const SizedBox(height: 22),
                      Text('Autor: ${articulo.usuario}',
                          style: const TextStyle(
                              color: AppTheme.textSecondary, fontSize: 13)),
                      if (articulo.url.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text('Enlace: ${articulo.url}',
                            style: const TextStyle(
                                color: AppTheme.accent, fontSize: 13)),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // buscador
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.border),
            ),
            child: const Row(
              children: [
                Icon(Icons.search_rounded,
                    color: AppTheme.textSecondary, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: AppTheme.textPrimary, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Buscar modelos...',
                      hintStyle: TextStyle(
                          color: AppTheme.textSecondary, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Grids
        Expanded(
          child: StreamBuilder<List<Articulos>>(
            stream: DatabaseService().articulosStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error al cargar los artículos',
                      style: TextStyle(
                          color: AppTheme.textSecondary, fontSize: 14)),
                );
              }

              final articulos = snapshot.data ?? [];
              if (articulos.isEmpty) {
                return const Center(
                  child: Text('No hay artículos disponibles',
                      style: TextStyle(
                          color: AppTheme.textSecondary, fontSize: 14)),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                itemCount: articulos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.84,
                ),
                itemBuilder: (context, i) {
                  final articulo = articulos[i];
                  final color = _colorForCategory(articulo.categoria);
                  final icon = _iconForCategory(articulo.categoria);

                  return GestureDetector(
                    onTap: () => _showArticuloDetail(context, articulo),
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
                              child: Center(
                                child: Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(icon, color: color, size: 28),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(articulo.articulo,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: AppTheme.textPrimary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13)),
                                const SizedBox(height: 6),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: color),
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(articulo.categoria,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: AppTheme.textSecondary,
                                              fontSize: 11)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}