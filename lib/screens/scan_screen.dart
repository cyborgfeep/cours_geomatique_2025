import 'package:camera/camera.dart';
import 'package:cours_geomatique_2025/main.dart';
import 'package:cours_geomatique_2025/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController controller;
  late PageController pageController;
  bool isFlashOn = false;
  int pageIndex = 0;

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
    //Instancier Page controller
    pageController = PageController(initialPage: 0);
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
            PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                scanWidget(),
                Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: CardWidget(width: 400, height: 250),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.clear, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              left: 30,
              right: 30,
              child: ToggleSwitch(
                minWidth: 200.0,
                cornerRadius: 20.0,
                activeBgColors: [
                  [Colors.grey],
                  [Colors.white],
                ],
                activeFgColor: pageIndex == 0 ? Colors.white : Colors.black,
                inactiveBgColor: pageIndex == 0 ? Colors.black : Colors.grey,
                inactiveFgColor: pageIndex == 0 ? Colors.white : Colors.black,
                initialLabelIndex: 0,
                totalSwitches: 2,
                labels: ['Scanner un code', 'Ma carte'],
                radiusStyle: true,
                onToggle: (index) {
                  //setState(() {
                  pageIndex = index!;

                  pageController.jumpToPage(pageIndex);
                  setState(() {});
                  //});
                  print('switched to: $index');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  scanWidget() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: MediaQuery.of(context).size.aspectRatio,
          child: CameraPreview(controller),
        ),
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: .6),
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Positioned(bottom: 100, child: Text("Scanner un Code Qr")),

              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Positioned(
                bottom: 200,
                left: 100,
                right: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Scanner un Code Qr")],
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 300,
                  width: 300,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.clear, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isFlashOn = !isFlashOn;
                    if (isFlashOn) {
                      controller.setFlashMode(FlashMode.torch);
                    } else {
                      controller.setFlashMode(FlashMode.off);
                    }
                  });
                },
                icon: Icon(
                  isFlashOn ? Icons.flash_off : Icons.flash_on,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
