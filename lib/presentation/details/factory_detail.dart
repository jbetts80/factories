import 'package:flutter/material.dart';

import 'package:factories/domain/models/factory.dart';

class FactoryDetail extends StatelessWidget {
  static final String routeName = '/factory-detail';

  @override
  Widget build(BuildContext context) {
    final factory = ModalRoute.of(context)!.settings.arguments as Factory;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              image: factory.image,
              placeholder: 'assets/images/loading.gif',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(factory.name),
                const SizedBox(height: 20.0),
                Text(
                  'Address',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(factory.address),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
