import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:tyba_flutter_challenge/models/university.dart';

Future<List<University>> getUniversities() async {
  final response = await http.get(Uri.parse(
      'https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json'));
  final body = decodeBody(response.bodyBytes);
  final data = jsonDecode(body);
  final ret = <University>[];
  for (final item in data) {
    ret.add(University.fromJson(item));
  }
  return ret;
}

String decodeBody(Uint8List body) => Encoding.getByName('utf-8')!.decode(body);
