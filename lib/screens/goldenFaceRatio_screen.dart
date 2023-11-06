import 'dart:convert';
import 'dart:typed_data';

import 'package:beauty_best_award/api/backend_api.dart';
import 'package:beauty_best_award/components/imageSlider.dart';
import 'package:beauty_best_award/constants/styles.dart';
import 'package:beauty_best_award/constants/text.dart';
import 'package:beauty_best_award/models/GodlenFaceResult.dart';
import 'package:flutter/material.dart';

class GoldenFace extends StatefulWidget {
  final Uint8List participantImage;
  const GoldenFace({super.key, required this.participantImage});

  @override
  State<GoldenFace> createState() => _GoldenFaceState();
}

class _GoldenFaceState extends State<GoldenFace> {
  List<Uint8List>? goldenRatioMasks;
  Uint8List? outputImage;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        -kToolbarHeight;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: screenWidth,
            height: screenHeight * 0.2,
            color: appColors.black,
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.06, left: screenWidth * 0.25),
              child: Text(
                goldenFaceRatioScreenText.title,
                style: openSansFont30ptWhite,
                softWrap: true,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          FutureBuilder(
            future: Future.wait(
              [BackendAPI.GetGoldenFaceImagesResults(widget.participantImage)],
            ),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasError) {
                return Container(
                  margin: EdgeInsets.only(top:screenHeight * 0.3, ),
                  child: const Text(
                    "Please reload and upload another image.",
                    style: openSansFont16ptBlack,
                    softWrap: true,
                  ),
                ); //Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                GoldenFaceResult result = snapshot.data![0] as GoldenFaceResult;

                return Center(
                  child: PhotoSliderWidget(
                    goldenFaceResult: result,
                    participantImage: widget.participantImage,
                  ),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.25,
                    ),
                    const Center(
                      child: SizedBox(
                        width: 100, // Adjust the width to set the size
                        height: 100, // Adjust the height to set the size
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(appColors.orange),
                          strokeWidth: 5,
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Uint8List decodeBase64Image(String base64String) {
    final List<int> bytes = base64.decode(base64String);
    return Uint8List.fromList(bytes);
  }
}
