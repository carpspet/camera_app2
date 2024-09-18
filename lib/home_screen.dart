import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:gallery_saver/gallery_saver.dart';
import 'camera_service.dart';
import 'photo_grid.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Uint8List> images = [];
  bool isLoading = false;
  String? errorMessage;

  void takePicture() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      Uint8List image = await CameraService.takePicture();
      images.add(image);

      // Save to gallery
      await GallerySaver.saveImage(image.toString(), albumName: 'CameraApp');
    } catch (e) {
      setState(() {
        errorMessage = "Error accessing the camera: ${e.toString()}";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera App'),
      ),
      body: Column(
        children: [
          if (isLoading) CircularProgressIndicator(),
          if (errorMessage != null)
            Text(
              errorMessage!,
              style: TextStyle(color: Colors.red),
            ),
          Expanded(
            child: PhotoGrid(images: images),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: takePicture,
              icon: Icon(Icons.camera),
              label: Text('Take Picture'),
            ),
          ),
        ],
      ),
    );
  }
}
