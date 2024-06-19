import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:first_flutter_project/model/model_surat_jalan.dart';

class ApiService{
  static const String apiUrl = "http://10.14.90.223:44/api/SuratJalan";

  static Future<List<NoSuratJalan>> fetchSuratJalan(String OSNumber) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'OSNumber': OSNumber,
      }),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['listSuratjalan'];
      return jsonResponse.map((data) => NoSuratJalan.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load SuratJalan');
    }
  }
}