class Usuarios {
  String usuario;
  String nombre;
  String apellidos;
  String correo;
  String password;
  String telefono;
  String fechaNacimiento;
  bool activo;

  Usuarios({
    required this.usuario,
    required this.nombre,
    required this.apellidos,
    required this.correo,
    required this.password,
    required this.telefono,
    required this.fechaNacimiento,
    required this.activo,
  });

  Usuarios.fromJson(Map<String, Object?> json)
      : this(
          usuario: json['usuario']! as String,
          nombre: json['nombre']! as String,
          apellidos: json['apellidos']! as String,
          correo: json['correo']! as String,
          password: json['password']! as String,
          telefono: json['telefono']! as String,
          fechaNacimiento: json['fechaNacimiento']! as String,
          activo: json['activo']! as bool,
        );

  Usuarios copyWith({
    String? usuario,
    String? nombre,
    String? apellidos,
    String? correo,
    String? password,
    String? telefono,
    String? fechaNacimiento,
    bool? activo,
  }) {
    return Usuarios(
      usuario: usuario ?? this.usuario,
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      correo: correo ?? this.correo,
      password: password ?? this.password,
      telefono: telefono ?? this.telefono,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      activo: activo ?? this.activo,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'usuario': usuario,
      'nombre': nombre,
      'apellidos': apellidos,
      'correo': correo,
      'password': password,
      'telefono': telefono,
      'fechaNacimiento': fechaNacimiento,
      'activo': activo,
    };
  }
}
