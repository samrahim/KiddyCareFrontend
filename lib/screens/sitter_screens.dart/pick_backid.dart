import 'package:babysitter/screens/sitter_screens.dart/verify_backid.dart';
import 'package:babysitter/widgets/costume_column.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PickBackImageIdCard extends StatefulWidget {

  const PickBackImageIdCard({
    super.key,
  });

  @override
  _PickBackImageIdCardState createState() => _PickBackImageIdCardState();
}

class _PickBackImageIdCardState extends State<PickBackImageIdCard> {
  late CameraController _controller;
  String cameraName = "0";

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
        enableAudio: true,
        CameraDescription(
            name: cameraName,
            lensDirection: CameraLensDirection.back,
            sensorOrientation: 0),
        ResolutionPreset.high);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth / 16;
    double middleContainerWidth = screenWidth - 2 * containerWidth;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CameraPreview(_controller,
                  child: CustomColumn(
                      containerWidth: containerWidth,
                      middleContainerWidth: middleContainerWidth)),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 10),
                  FittedBox(
                    child: const Text(
                      'Back ID Card',
                      style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  FittedBox(
                    child: const Text(
                      'Please point the camera at the ID card',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                  Container(
                    width: MediaQuery.of(context).size.width - 16,
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          await _controller.takePicture().then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VerificationBackIdCard(
                                          backcardIdPath: value.path,
                                        )));
                          });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 4),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(70)),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(21, 115, 254, 1),
                                  borderRadius: BorderRadius.circular(70)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 3.5),
                      InkWell(
                          onTap: () {
                            if (_controller.description.name == "1" &&
                                _controller.description.lensDirection ==
                                    CameraLensDirection.front) {
                              _controller = CameraController(
                                  enableAudio: true,
                                  const CameraDescription(
                                      name: "0",
                                      lensDirection: CameraLensDirection.back,
                                      sensorOrientation: 0),
                                  ResolutionPreset.veryHigh);
                            } else {
                              _controller = CameraController(
                                  enableAudio: true,
                                  const CameraDescription(
                                      name: "1",
                                      lensDirection: CameraLensDirection.front,
                                      sensorOrientation: 0),
                                  ResolutionPreset.veryHigh);
                            }
                            _controller.initialize().then((_) {
                              if (!mounted) {
                                return;
                              }
                              setState(() {});
                              
                            });
                          },
                          child: const Icon(
                            Icons.flip_camera_ios_sharp,
                            color: Color.fromRGBO(21, 115, 254, 1),
                            size: 40,
                          )),
                      const SizedBox(width: 12)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
