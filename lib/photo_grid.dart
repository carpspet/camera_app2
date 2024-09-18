import 'package:flutter/material.dart';
import 'dart:typed_data';

class PhotoGrid extends StatelessWidget {
  final List<Uint8List> images;

  const PhotoGrid({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Image.memory(images[index], fit: BoxFit.cover);
      },
    );
  }
}
