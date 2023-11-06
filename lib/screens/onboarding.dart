import 'dart:typed_data';
import 'dart:ui';
import 'package:beauty_best_award/constants/styles.dart';
import 'package:beauty_best_award/constants/text.dart';
import 'package:beauty_best_award/screens/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        -kToolbarHeight;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/Screen1.png"),
                      fit: BoxFit.cover))),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 10),
            child: Container(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: screenHeight * 0.10,
                    ),
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
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              onboardingScreenText.title1,
                              style: openSansFont25ptWhite,
                            ),
                            Text(
                              onboardingScreenText.title2,
                              style: openSansFont25ptOrange,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.45,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
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
                        width: screenWidth * 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(251, 176, 64, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () async {
                            final List<CameraDescription> cameras =
                                await availableCameras();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (final BuildContext context) =>
                                    TakePictureScreen(
                                  cameras: cameras,
                                  description: cameras.first,
                                ),
                              ),
                            );
                          },
                          child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 12, bottom: 12),
                              child: Text(onboardingScreenText.buttonText,
                                  style: openSansFont16ptBlack)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
