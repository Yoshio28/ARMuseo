class ArticulosUsuarios {
  int idA;

  ArticulosUsuarios({
    required this.idA,
  });

  ArticulosUsuarios.fromJson(Map<String, Object?> json)
      : this(
          idA: json['idA']! as int,
        );

  ArticulosUsuarios copyWith({
    int? idA,
  }) {
    return ArticulosUsuarios(
      idA: idA ?? this.idA,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'idA': idA,
    };
  }
}
