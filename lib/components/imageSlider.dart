import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:beauty_best_award/constants/styles.dart';
import 'package:beauty_best_award/helper.dart';
import 'package:beauty_best_award/models/GodlenFaceResult.dart';
import 'package:beauty_best_award/screens/lookAlike_screen.dart';
import 'package:flutter/material.dart';

class PhotoSliderWidget extends StatefulWidget {
  final GoldenFaceResult goldenFaceResult;
  final Uint8List participantImage;

  const PhotoSliderWidget(
      {super.key,
      required this.goldenFaceResult,
      required this.participantImage});

  @override
  _PhotoSliderWidgetState createState() => _PhotoSliderWidgetState();
}

class _PhotoSliderWidgetState extends State<PhotoSliderWidget> {
  int currentIndex = 0;

  late Timer timer;
  late List<Uint8List>? imageList;

  @override
  void initState() {
    super.initState();
    imageList = widget.goldenFaceResult.goldenMasks
        .map((String? img) => decodeBase64Image(img!))
        .toList() as List<Uint8List>?;
    imageList!.add(widget.participantImage);
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      if (currentIndex < imageList!.length - 1) {
        setState(() {
          currentIndex++;
        });
      } else {
        // Stop the timer when we reach the last image
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        -kToolbarHeight;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              AnimatedSwitcher(
                duration: Duration(seconds: 2),
                child: Container(
                    key: ValueKey<int>(
                        currentIndex), // Key helps AnimatedSwitcher identify the widget changes
                    height: screenHeight * 0.5,
                    width: screenWidth,
                    child: FadeTransition(
                      opacity: AlwaysStoppedAnimation(1.0),
                      child: Image.memory(
                        imageList![currentIndex],
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              if (currentIndex >= imageList!.length - 1)
                Container(
                  color: appColors.orange,
                  margin: EdgeInsets.only(
                      top: screenHeight * 0.025),
                  padding: EdgeInsets.only(left: screenWidth * 0.01),
                  child: Text(
                    "Your Golden Ratio: ${widget.goldenFaceResult.goldenRatio.toStringAsFixed(2)} %",
                    style: openSansFont20ptBlack,
                  ),
                )
            ],
          ),
          SizedBox(
            height: screenHeight * 0.035,
          ),
          currentIndex < imageList!.length - 1
              ? SizedBox(
                  width: 90,
                  height: 90,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(appColors.orange),
                    strokeWidth: 5,
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.05,
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
                      width: screenWidth * 0.9,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(251, 176, 64, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (final BuildContext context) =>
                                    LookAlikeResults(
                                      goldenFaceResult: widget.goldenFaceResult,
                                      participantImage: widget.participantImage,
                                    )),
                          );
                        },
                        child: const Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            child: Text("See your celebrity look alike",
                                style: openSansFont16ptBlack)),
                      ),
                    ),
                  ],
                )
        ]);
  }

  //.only(left: 16.0, right: 16.0, top: 12, bottom: 12),

}
