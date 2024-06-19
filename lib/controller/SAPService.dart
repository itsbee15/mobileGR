import 'dart:convert';
import 'package:http/http.dart' as http;

class SAPService {
  String baseUrl = "http://aoph1qappdc.aop.oto:8020";
  final String username;
  final String password;

  SAPService(this.baseUrl, this.username, this.password);

  String _basicAuth() {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return basicAuth;
  }

  Future<http.Response> sendDataToSAP(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/sap/zrest/mfg/gr_os'); // Ganti 'endpoint' dengan endpoint yang sesuai.
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': _basicAuth(),
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to send data to SAP');
    }
  }
}