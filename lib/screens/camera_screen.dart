import 'dart:async';
import 'package:beauty_best_award/screens/photoCheck_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class TakePictureScreen extends StatefulWidget {
  TakePictureScreen(
      {super.key, required this.cameras, required this.description});

  final List<CameraDescription> cameras;
  CameraDescription description;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initCamera(widget.description);
  }

  void _initCamera(CameraDescription description) {
    _controller = CameraController(description, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CameraPreview(_controller),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: AppBar(
                        backgroundColor:
                            Color.fromRGBO(87, 85, 82, 1).withOpacity(0.5),
                        elevation: 0,
                        leading: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Color.fromRGBO(87, 85, 82, 1).withOpacity(0.5),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  await _initializeControllerFuture;
                                  final XFile image =
                                      await _controller.takePicture();
                                  final Uint8List imageBytes =
                                      await image.readAsBytes();
                                  if (!mounted) return;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (final BuildContext context) =>
                                          checkPhotoScreen(
                                        takenimage: imageBytes,
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  print(e);
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                elevation: MaterialStateProperty.all(0),
                              ),
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (widget.description ==
                                      widget.cameras.first) {
                                    widget.description = widget.cameras.last;
                                  } else {
                                    widget.description = widget.cameras.first;
                                  }

                                  if (widget.description != null) {
                                    _initCamera(widget.description);
                                  } else {
                                    print('Asked camera not available');
                                  }
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                elevation: MaterialStateProperty.all(0),
                              ),
                              child: Icon(
                                Icons.cameraswitch_rounded,
                                color: Colors.white,
                                size: 60,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
}
