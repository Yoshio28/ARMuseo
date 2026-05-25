// lib/screens/models_screen.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/model_detail_sheet.dart';

class ModelsScreen extends StatefulWidget {
  const ModelsScreen({super.key});

  @override
  State<ModelsScreen> createState() => _ModelsScreenState();
}

class _ModelsScreenState extends State<ModelsScreen> {
  final List<ModelData> _models = const [
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
  ];

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
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemCount: _models.length,
            itemBuilder: (context, i) {
              final m = _models[i];
              return GestureDetector(
                onTap: () => showModelDetail(context, m),
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
                            color: m.color.withOpacity(0.08),
                          ),
                          child: Center(
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: m.color.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(m.icon, color: m.color, size: 28),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m.name,
                                maxLines: 2,
                                style: const TextStyle(
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: m.color),
                                ),
                                const SizedBox(width: 5),
                                Text(m.category,
                                    style: const TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 11)),
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
          ),
        ),
      ],
    );
  }
}
