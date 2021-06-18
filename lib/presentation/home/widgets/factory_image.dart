import 'package:flutter/material.dart';

class FactoryImage extends StatelessWidget {
  const FactoryImage({required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 50.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          image: image,
          placeholder: 'assets/images/loading.gif',
        ),
      ),
    );
  }
}
