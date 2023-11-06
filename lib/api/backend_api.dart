import 'dart:convert';

import 'package:beauty_best_award/models/GodlenFaceResult.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'api_constants.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';

class BackendAPI {
  static const String username = "skinai@skinopathy.com";
  static const String password = "JMA5nVBtnGvK9t4ZCk";
  static String basicAuth =
      // ignore: prefer_interpolation_to_compose_strings
      'Basic ' + base64Encode(utf8.encode('$username:$password'));

  static Future<GoldenFaceResult> GetGoldenFaceImagesResults(
      Uint8List image) async {
    Uri uri = Uri.parse([
      APIconstants.apiBase,
      APIconstants.goldenRatios,
    ].join("/"));

    var headers = {
      'Authorization': basicAuth,
      'Accept': '*/*',
    };
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    print(
      http.MultipartFile.fromBytes('file', image
          //filename: "test.jpeg",
          //contentType: MediaType('image', 'jpg'),
          ),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        image,
        filename: "participant.jpeg",
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    var response = await request.send();
    print(response.statusCode);

    // if (response.statusCode == 200) {
    var responseString = await response.stream.bytesToString();
    Map<String, dynamic> map = json.decode(responseString);
    //print(map); 
    print(map['result']['goldenRatio']);
    print(map['result']['celebrityName']);
    print(map['result']['id']);
    ;
    dynamic decodedMap = GoldenFaceResult.fromJson(map);
    print(decodedMap);
    return decodedMap;
    // } else {
    //   print(response.reasonPhrase);
    //   return null;
    // }

    // http.MultipartRequest request = http.MultipartRequest('POST', uri);
    // request.headers.addAll({"Authorization": "Bearer $token"});

    // for (Uint8List image in imageList) {
    //   request.files.add(
    //     http.MultipartFile.fromBytes('files', image,
    //         filename: "${uuid.v4()}.jpg"),
    //   );
    // }
    // var response = await request.send();

    // var responseString = await response.stream.bytesToString();
    // List<dynamic> decodedMap = json.decode(responseString)['imageUrls'];
    // return (decodedMap.map((item) => item.toString()).toList());
  }

  static Future<String?> PutEmailAndID(String id, String email) async {
    Uri uri = Uri.parse([
      APIconstants.apiBase,
      APIconstants.goldenRatios,
    ].join("/"));

    var headers = {
      'Authorization': basicAuth,
    };

    var request =
        http.Request('PUT', Uri.parse('${uri}?id=${id}&email=${email}'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return json.decode(await response.stream.bytesToString())["message"];
    } else {
      return response.reasonPhrase;
    }
  }
}
