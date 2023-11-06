import 'dart:typed_data';

import 'package:beauty_best_award/api/backend_api.dart';
import 'package:beauty_best_award/constants/styles.dart';
import 'package:beauty_best_award/constants/text.dart';
import 'package:beauty_best_award/helper.dart';
import 'package:beauty_best_award/models/GodlenFaceResult.dart';
import 'package:beauty_best_award/screens/goldenFaceRatio_screen.dart';
import 'package:beauty_best_award/screens/onboarding.dart';
import 'package:flutter/material.dart';

class LookAlikeResults extends StatefulWidget {
  final GoldenFaceResult goldenFaceResult;
  final Uint8List participantImage;
  const LookAlikeResults(
      {super.key,
      required this.goldenFaceResult,
      required this.participantImage});

  @override
  State<LookAlikeResults> createState() => _LookAlikeResultsState();
}

class _LookAlikeResultsState extends State<LookAlikeResults> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        -kToolbarHeight;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.1),
                child: Text(
                  lookAlikeScreenText.title,
                  textAlign: TextAlign.left,
                  style: openSansFont16ptBlack,
                ),
              ),
              // SizedBox(
              //     height: screenHeight * 0.05,
              //     child: ),

              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.1),
                child: Text(
                  widget.goldenFaceResult.celebrityName ?? "",
                  textAlign: TextAlign.left,
                  style: openSansFont25ptBlack,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    height: screenHeight * 0.3,
                    width: screenWidth,
                    // ignore: sort_child_properties_last
                    child: Image.memory(
                      decodeBase64Image(
                        widget.goldenFaceResult.getOutputImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    height: screenHeight * 0.3,
                    width: screenWidth,
                    child: Image.memory(
                      widget.participantImage,
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    )),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Colors.black, width: 1.0),
              //       ),
              //       width: screenWidth * 0.5,
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Color.fromRGBO(251, 176, 64, 1),
              //         ),
              //         onPressed: () {
              //           //Navigator.pop(context);
              //         },
              //         child: Padding(
              //             padding: EdgeInsets.only(
              //                 left: 16.0, right: 16.0, top: 12, bottom: 12),
              //             child: Text("Look alike",
              //                 style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 16.0))),
              //       ),
              //     ),
              //     Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Colors.black, width: 1.0),
              //       ),
              //       width: screenWidth * 0.5,
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: appColors.white,
              //         ),
              //         onPressed: () {},
              //         child: Padding(
              //             padding: EdgeInsets.only(
              //                 left: 16.0, right: 16.0, top: 12, bottom: 12),
              //             child: Text("You",
              //                 style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.w600,
              //                     fontSize: 16.0))),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: screenHeight * 0.025,
              ),
              Center(
                  child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    width: screenWidth * 0.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.orange,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => PopUpWidget(id: widget.goldenFaceResult.id ?? "",),
                        );
                      },
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12, bottom: 12),
                          child: Text(lookAlikeScreenText.shareText,
                              style: openSansFont16ptBlack)),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    width: screenWidth * 0.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (final BuildContext context) =>
                                  Onboarding()),
                        );
                      },
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12, bottom: 12),
                          child: Text(lookAlikeScreenText.restartText,
                              style: openSansFont16ptBlack)),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class PopUpWidget extends StatefulWidget {
  final String id;

  const PopUpWidget({super.key, required this.id}); 
  @override
  _PopUpWidgetState createState() => _PopUpWidgetState();
}

class _PopUpWidgetState extends State<PopUpWidget> {
  TextEditingController textController = TextEditingController();
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   "Email",
            //   textAlign: TextAlign.left,
            //   style: openSansFont20ptBlack,
            // ),
            TextField(
              controller: textController,
              cursorColor: appColors.orange,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: openSansFont16ptBlack,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: appColors.orange),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              //width: screenWidth * 0.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.orange,
                ),
                onPressed: () async {
                  var result = await BackendAPI.PutEmailAndID(
                      widget.id,
                      textController.text);

                  print(result ?? "empty");
                  setState(() {
                    text = textController.text;
                  });
                  Navigator.of(context).pop();
                  // You can now use the 'text' variable to access the entered text.
                  print('Entered Text: $text');
                },
                child: Text(
                  'Send',
                  style: openSansFont16ptBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
