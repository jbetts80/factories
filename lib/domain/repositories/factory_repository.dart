import 'package:factories/domain/models/factory.dart';

abstract class FactoryRepository {
  Future<List<Factory>> fetchAllFactories();
  Future<void> save(Factory factory);
}
