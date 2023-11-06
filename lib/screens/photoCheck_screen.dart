import 'dart:typed_data';

import 'package:beauty_best_award/constants/styles.dart';
import 'package:beauty_best_award/constants/text.dart';
import 'package:beauty_best_award/screens/goldenFaceRatio_screen.dart';
import 'package:beauty_best_award/screens/lookAlike_screen.dart';
import 'package:flutter/material.dart';

class checkPhotoScreen extends StatelessWidget {
  final Uint8List takenimage;
  checkPhotoScreen({super.key, required this.takenimage});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        -kToolbarHeight;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Container(
          //     decoration: BoxDecoration(
          //         image: DecorationImage(
          //             image: AssetImage("assets/img/happyWithPhoto.png"),
          //             fit: BoxFit.cover))),
          Container(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: screenWidth * 0.35,
                        height: screenWidth * 0.35,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/img/SkinopathyLogoIcon.png"),
                              fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.55,
                        child: Text(
                          photoCheckScreenText.title,
                          style: openSansFont30ptBlack,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: screenHeight * 0.6,
                      width: screenWidth,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: MemoryImage(takenimage),
                              fit: BoxFit.cover))),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 6),
                                  blurRadius: 6,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: screenHeight * 0.2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(251, 176, 64, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(15), // <-- Radius
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.0,
                                      right: 16.0,
                                      top: 12,
                                      bottom: 12),
                                  child: Text(photoCheckScreenText.buttonRetake,
                                      style: openSansFont16ptBlack)),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 6),
                                  blurRadius: 6,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: screenHeight * 0.2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(251, 176, 64, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(15), // <-- Radius
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (final BuildContext context) =>
                                          //LookAlikeResults()),
                                          GoldenFace(participantImage: takenimage)),
                                );
                              },
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.0,
                                      right: 16.0,
                                      top: 12,
                                      bottom: 12),
                                  child: Text(photoCheckScreenText.buttonRun,
                                      style: openSansFont16ptBlack)),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
