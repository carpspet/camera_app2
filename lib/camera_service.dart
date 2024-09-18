import 'package:camera/camera.dart';
import 'dart:typed_data';

class CameraService {
  static CameraController? _controller;

  static Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    _controller = CameraController(camera, ResolutionPreset.medium);
    await _controller!.initialize();
  }

  static Future<Uint8List> takePicture() async {
    if (_controller == null) {
      await initializeCamera();
    }

    XFile file = await _controller!.takePicture();
    return await file.readAsBytes(); // convert the image into Uint8List
  }

  static void dispose() {
    _controller?.dispose();
  }
}
