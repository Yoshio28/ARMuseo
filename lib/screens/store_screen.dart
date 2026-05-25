// lib/screens/store_screen.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/model_detail_sheet.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<ModelData> _popular = const [
    ModelData(
      name: 'Motor V8 3D',
      category: 'Mecánica',
      icon: Icons.electric_bolt_rounded,
      color: Color(0xFF00D4FF),
      price: '\$4.99',
      description:
          'Réplica 3D de alta fidelidad de un motor V8 de gasolina con todas sus piezas móviles: pistones, cigüeñal, árbol de levas y sistema de escape completo.',
      format: 'GLTF / GLB',
      size: '14.7 MB',
      polygons: '48,300',
      tags: ['motor', 'V8', 'automóvil', 'mecánica'],
    ),
    ModelData(
      name: 'Célula Animal',
      category: 'Biología',
      icon: Icons.biotech_rounded,
      color: Color(0xFF10B981),
      price: 'Gratis',
      description:
          'Modelo didáctico de una célula animal eucariota con todos sus orgánulos identificados: núcleo, mitocondrias, retículo endoplasmático, aparato de Golgi y membrana celular.',
      format: 'OBJ / MTL',
      size: '5.2 MB',
      polygons: '19,100',
      tags: ['biología', 'célula', 'orgánulos', 'educación'],
    ),
    ModelData(
      name: 'Sistema Solar',
      category: 'Astronomía',
      icon: Icons.public_rounded,
      color: Color(0xFF7C3AED),
      price: '\$2.99',
      description:
          'Representación a escala del sistema solar con los 8 planetas, sus lunas principales, el cinturón de asteroides y el cometa Halley en su trayectoria orbital.',
      format: 'GLTF / GLB',
      size: '8.9 MB',
      polygons: '27,600',
      tags: ['astronomía', 'planetas', 'espacio', 'ciencia'],
    ),
    ModelData(
      name: 'Puente Colgante',
      category: 'Ingeniería',
      icon: Icons.architecture_rounded,
      color: Color(0xFFF59E0B),
      price: '\$1.99',
      description:
          'Modelo estructural de un puente colgante con cables de acero, torres de soporte y tablero vehicular. Incluye análisis de fuerzas y distribución de cargas.',
      format: 'FBX',
      size: '7.1 MB',
      polygons: '22,400',
      tags: ['ingeniería', 'puente', 'estructura', 'construcción'],
    ),
  ];

  final List<ModelData> _newModels = const [
    ModelData(
      name: 'Corazón Humano',
      category: 'Medicina',
      icon: Icons.favorite_rounded,
      color: Color(0xFFEC4899),
      price: '\$3.99',
      description:
          'Modelo anatómico detallado del corazón humano con aurículas, ventrículos, válvulas y principales arterias y venas. Incluye animación del ciclo cardíaco.',
      format: 'GLTF / GLB',
      size: '11.3 MB',
      polygons: '36,700',
      tags: ['medicina', 'anatomía', 'corazón', 'salud'],
    ),
    ModelData(
      name: 'Reactor Nuclear',
      category: 'Física',
      icon: Icons.energy_savings_leaf_rounded,
      color: Color(0xFF10B981),
      price: '\$5.99',
      description:
          'Corte transversal de un reactor nuclear de agua a presión (PWR). Visualiza el núcleo reactor, los sistemas de refrigeración y las barras de control.',
      format: 'FBX',
      size: '16.2 MB',
      polygons: '52,100',
      tags: ['física', 'nuclear', 'energía', 'reactor'],
    ),
    ModelData(
      name: 'ADN Doble Hélice',
      category: 'Biología',
      icon: Icons.science_rounded,
      color: Color(0xFF7C3AED),
      price: 'Gratis',
      description:
          'Estructura tridimensional del ADN con representación de los cuatro nucleótidos (adenina, timina, guanina, citosina) y sus enlaces de hidrógeno.',
      format: 'GLTF / GLB',
      size: '3.8 MB',
      polygons: '14,200',
      tags: ['biología', 'ADN', 'genética', 'bioquímica'],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barra de búsqueda
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded,
                    color: AppTheme.textSecondary, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(
                        color: AppTheme.textPrimary, fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: 'Buscar modelos en la tienda...',
                      hintStyle: TextStyle(
                          color: AppTheme.textSecondary, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Buscar',
                        style: TextStyle(
                            color: AppTheme.accent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Modelos populares
          const Text('Modelos populares',
              style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 17)),
          const SizedBox(height: 14),
          SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _popular.length,
              itemBuilder: (context, i) {
                final m = _popular[i];
                return GestureDetector(
                  onTap: () => showModelDetail(context, m),
                  child: Container(
                    width: 148,
                    margin: const EdgeInsets.only(right: 12),
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
                            decoration: BoxDecoration(
                              color: m.color.withOpacity(0.08),
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(18)),
                            ),
                            child: Center(
                              child: Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: m.color.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(14),
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
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: AppTheme.textPrimary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12)),
                              const SizedBox(height: 5),
                              Text(
                                m.price!,
                                style: TextStyle(
                                    color: m.price == 'Gratis'
                                        ? AppTheme.success
                                        : AppTheme.accent,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12),
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
          const SizedBox(height: 28),

          // Modelos nuevos
          const Text('Modelos nuevos',
              style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 17)),
          const SizedBox(height: 14),
          ..._newModels.map((m) => GestureDetector(
                onTap: () => showModelDetail(context, m),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
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
                          color: m.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Icon(m.icon, color: m.color, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m.name,
                                style: const TextStyle(
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)),
                            const SizedBox(height: 3),
                            Text(m.category,
                                style: const TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 12)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: m.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: m.color.withOpacity(0.25)),
                        ),
                        child: Text(
                          m.price!,
                          style: TextStyle(
                              color: m.price == 'Gratis'
                                  ? AppTheme.success
                                  : m.color,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
