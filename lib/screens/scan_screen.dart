import 'package:camera/camera.dart';
import 'package:cours_geomatique_2025/main.dart';
import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    //Instancier l'objet CameraController
    controller = CameraController(cameras[0], ResolutionPreset.max);
    //Initialiser l'objet CameraController
    controller
        .initialize()
        .then((_) {
          if (!mounted) {
            return;
          }
          //Actualiser l'interface graphique
          setState(() {
            getZoomLevel();
            controller.setZoomLevel(2.5);
          });
        })
        .catchError((Object e) {
          if (e is CameraException) {
            switch (e.code) {
              case 'CameraAccessDenied':
                // Handle access errors here.
                break;
              default:
                // Handle other errors here.
                print(e);
                break;
            }
          }
        });
  }

  getZoomLevel() async {
    await controller.getMaxZoomLevel().then((value) {
      print('Zoom Level: ${value}');
    });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: MediaQuery.of(context).size.aspectRatio,
              child: CameraPreview(controller),
            ),
          ],
        ),
      ),
    );
  }
}
