import 'dart:convert';
import 'dart:typed_data';

class GoldenFaceResult {
  List<String?> goldenMasks;
  String? outputImage;
  double goldenRatio;
  String? celebrityName;
  String? id;
  get getGoldenMasks => this.goldenMasks;

 set setGoldenMasks( goldenMasks) => this.goldenMasks = goldenMasks;

  get getOutputImage => this.outputImage;

 set setOutputImage( outputImage) => this.outputImage = outputImage;

  get getGoldenRatio => this.goldenRatio;

 set setGoldenRatio( goldenRatio) => this.goldenRatio = goldenRatio;

  get getCelebrityName => this.celebrityName;

 set setCelebrityName( celebrityName) => this.celebrityName = celebrityName;

  get getId => this.id;

 set setId( id) => this.id = id;

  GoldenFaceResult({
    required this.goldenMasks,
    required this.outputImage,
    required this.goldenRatio,
    required this.celebrityName,
    required this.id,
  });

  GoldenFaceResult.fromJson(Map<String, dynamic> json)
      : goldenMasks = List<String>.from(json['result']['goldenMasks']),
        outputImage = json['result']['outputImage'],
        goldenRatio = json['result']['goldenRatio'],
        celebrityName = json['result']['celebrityName'],
        id = json['result']['id'];

  @override
  String toString() {
    return 'GoldenFaceResult(goldenRatio: $goldenRatio, celebrityName: $celebrityName, id: $id)';
  }


  Uint8List decodeBase64Image(String base64String) {
  final List<int> bytes = base64.decode(base64String);
  return Uint8List.fromList(bytes);
}
}
