import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key, required this.cameras}) : super(key: key);
  List<CameraDescription>? cameras;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? cameraController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cameraController =
        new CameraController(widget.cameras![0], ResolutionPreset.max);
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController!.value.isInitialized) {
      return new Container();
    }
    return new AspectRatio(
      aspectRatio: cameraController!.value.aspectRatio,
      child: new CameraPreview(cameraController!),
    );
  }
}
