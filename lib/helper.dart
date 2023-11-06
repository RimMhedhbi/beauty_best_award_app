
  import 'dart:convert';
import 'dart:typed_data';

Uint8List decodeBase64Image(String base64String) {
    final List<int> bytes = base64.decode(base64String);
    return Uint8List.fromList(bytes);
  }