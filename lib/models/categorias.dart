class categoriaArt {
  String categoria;

  categoriaArt({
    required this.categoria,
  });

  categoriaArt.fromJson(Map<String, Object?> json)
      : this(
          categoria: json['categoria']! as String,
        );

  categoriaArt copyWith({
    String? categoria,
  }) {
    return categoriaArt(
      categoria: categoria ?? this.categoria,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'categoria': categoria,
    };
  }
}
