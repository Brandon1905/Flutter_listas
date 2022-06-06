import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listas/Estudiante.dart';

class EstudianteService {
  CollectionReference estudianteRef =
  FirebaseFirestore.instance.collection('estuduante');

  Future<List<Estudiante>> get() async {
    QuerySnapshot querySnapshot = await estudianteRef.get();
    return querySnapshot.docs
        .map((ds) => Estudiante.fromSnapshot(ds.id, ds.data()))
        .toList();
  }
}
