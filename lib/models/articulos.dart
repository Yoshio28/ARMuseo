class Articulos {
  String articulo;
  String categoria;
  String historia;
  String imagen;
  String url;
  String usuario;

  Articulos({
    required this.articulo,
    required this.categoria,
    required this.historia,
    required this.imagen,
    required this.url,
    required this.usuario,
  });

  Articulos.fromJson(Map<String, Object?> json) 
  :this(
      articulo : json['articulo']! as String,
      categoria : json['categoria']! as String,
      historia : json['historia']! as String,
      imagen : json['imagen']! as String,
      url : json['url']! as String,
      usuario : json['usuario']! as String,
      );

  Articulos copyWith ({
    String? articulo,
    String? categoria,
    String? historia,
    String? imagen,
    String? url,
    String? usuario,
      }) {
        return Articulos (articulo: articulo ?? this.articulo, 
        categoria: categoria ?? this.categoria, 
        historia: historia ?? this.historia,
        imagen: imagen ?? this.imagen,
        url: url ?? this.url,
        usuario: usuario ?? this.usuario);
      }
  
Map<String, Object?> toJson() {
  return {
    'articulo': articulo,
    'categoria': categoria,
    'historia': historia,
    'imagen': imagen,
    'url': url,
    'usuario': usuario,
  };
}
}