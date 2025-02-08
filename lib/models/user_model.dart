class User {
  String nombre;
  String email;
  String telefono;

  User({required this.nombre, required this.email, required this.telefono});

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'email': email,
      'telefono': telefono,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      nombre: map['nombre'],
      email: map['email'],
      telefono: map['telefono'],
    );
  }
}