import 'package:flutter/material.dart';

import 'package:factories/domain/models/factory.dart';
import 'package:factories/domain/repositories/factory_repository.dart';

class HomeBLoC extends ChangeNotifier {
  HomeBLoC({required this.factory});
  final FactoryRepository factory;

  final nameEditController = TextEditingController();
  final addressEditController = TextEditingController();
  bool isLoading = false;
  List<Factory> factories = List.empty();
  Stream<List<Factory>> factories2 = Stream.empty();

  Future<void> fetchAllFactories() async {
    factories = await factory.fetchAllFactories();
    notifyListeners();
  }

  Future<void> add(String imageUrl) async {
    isLoading = true;
    notifyListeners();

    final factoryModel = Factory(
      name: nameEditController.text,
      address: addressEditController.text,
      image: imageUrl,
    );
    await factory.save(factoryModel);
    factories.add(factoryModel);

    nameEditController.clear();
    addressEditController.clear();
    isLoading = false;
    notifyListeners();
  }
}
