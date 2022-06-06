class Estudiante {
  String nombre;
  String apellido;
  String edad;

  Estudiante(this.nombre, this.apellido, this.edad);

  Estudiante.fromSnapshot(String id, Map<String, dynamic> estudiante)
      : 
        nombre = estudiante['nombre'],
        apellido = estudiante['apellido'],
        edad = estudiante['edad'];

  Map<String, dynamic> toMap() => {
        'nombre' : nombre,
        'apellido': apellido,
        'edad': edad,
      };

  @override
  String toString() {
    return 'estuduante{nombre: $nombre, apellido: $apellido, edad: $edad}';
  }
}
