import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:factories/domain/models/factory.dart';
import 'package:factories/domain/repositories/factory_repository.dart';

class FactoryRepositoryImpl implements FactoryRepository {
  final _collectionRef = FirebaseFirestore.instance.collection('factories');

  @override
  Future<List<Factory>> fetchAllFactories() async {
    final querySnapshot = await _collectionRef.get();
    return querySnapshot.docs
        .map((documentSnapshot) => Factory.fromMap(documentSnapshot.data()))
        .toList();
  }

  @override
  Future<void> save(Factory factory) async {
    await _collectionRef.add(factory.toMap());
  }
}
