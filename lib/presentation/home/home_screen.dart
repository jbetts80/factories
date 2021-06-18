import 'dart:math';
import 'package:factories/presentation/details/factory_detail.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:factories/data/mocks/network_images.dart';
import 'package:factories/domain/models/factory.dart';
import 'package:factories/domain/repositories/factory_repository.dart';
import 'package:factories/presentation/home/home_bloc.dart';
import 'package:factories/presentation/home/widgets/factory_image.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeBLoC>(
      create: (_) => HomeBLoC(
        factory: Provider.of<FactoryRepository>(context, listen: false),
      )..fetchAllFactories(),
      builder: (_, __) => Home(),
    );
  }
}

class Home extends StatelessWidget {
  void _saveFactory(BuildContext context, String imageUrl) async {
    final factoryBloc = Provider.of<HomeBLoC>(context, listen: false);
    await factoryBloc.add(imageUrl);
    Navigator.of(context).pop();
  }

  void _showBottomSheet(BuildContext context) {
    String imageUrl = imagesMock[Random().nextInt(imagesMock.length)];
    final textStyle = const TextStyle(fontWeight: FontWeight.bold);
    final factoryBloc = Provider.of<HomeBLoC>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) => Container(
        padding: EdgeInsets.only(
          left: 20.0,
          top: 20.0,
          right: 20.0,
          bottom: 20.0 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 70.0,
                  child: Text(
                    'Image',
                    style: textStyle,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    'Name',
                    style: textStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FactoryImage(image: imageUrl),
                const SizedBox(width: 20.0),
                Flexible(
                  flex: 2,
                  child: TextField(
                    controller: factoryBloc.nameEditController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              'Address',
              style: textStyle,
            ),
            TextField(
              controller: factoryBloc.addressEditController,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => _saveFactory(context, imageUrl),
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final factoryBloc = Provider.of<HomeBLoC>(context);
    print('factoryBloc.factories: ${factoryBloc.factories}');
    return Scaffold(
      body: factoryBloc.factories.isEmpty
          ? Center(child: Text('There are no factories available'))
          : FactoriesList(factoryBloc.factories),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showBottomSheet(context),
      ),
    );
  }
}

class FactoriesList extends StatelessWidget {
  const FactoriesList(this.factories);
  final List<Factory> factories;

  void _showDetails(BuildContext context, Factory factory) {
    Navigator.of(context).pushNamed(
      FactoryDetail.routeName,
      arguments: factory,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext ctx, int index) => Divider(
        color: Colors.black,
        height: 0.1,
      ),
      itemCount: factories.length,
      itemBuilder: (BuildContext ctx, int index) {
        final factory = factories[index];
        return ListTile(
          leading: FactoryImage(image: factory.image),
          title: Text(factory.name),
          subtitle: Text(factory.address),
          onTap: () => _showDetails(context, factory),
        );
      },
    );
  }
}
