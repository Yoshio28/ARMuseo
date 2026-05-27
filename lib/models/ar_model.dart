// lib/models/ar_model.dart

class ArModel {
  final int index;
  final String name;
  final String category;
  final String description;
  final String glbPath;

  const ArModel({
    required this.index,
    required this.name,
    required this.category,
    required this.description,
    required this.glbPath,
  });
}

const List<ArModel> kArModels = [
  ArModel(
    index: 0,
    name: 'Dark Hooded Assassin',
    category: 'Arte Moderno',
    description:
        'Figura de guerrero encapuchado con estética oscura y detallada. '
        'Modelo 3D de alta fidelidad ideal para visualización en AR.',
    glbPath: 'assets/models/dark_hooded_assassin_warrior.glb',
  ),
  ArModel(
    index: 1,
    name: 'Red Apple',
    category: 'Escultura',
    description: 'Manzana roja hiperrealista con texturas detalladas. '
        'Perfecto para demostraciones de realidad aumentada en espacios cotidianos.',
    glbPath: 'assets/models/red_apple_-_realistic_fruit_asset.glb',
  ),
];
