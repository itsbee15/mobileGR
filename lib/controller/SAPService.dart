import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

mixin SAPService on Model {
  bool _isLoadingSendSAP = false;
  bool get isLoadingSendSAP => _isLoadingSendSAP;
  //
  String baseUrl = "http://aoph1qappdc.aop.oto:8020";
  // final String username;
  // final String password;

  // SAPService(this.baseUrl, this.username, this.password);

  String _basicAuth(String username, String password) {
    String basicAuth =
        "Basic ${utf8.fuse(base64).encode('$username:$password')}";
    // 'Basic ' + base64Encode(utf8.encode());
    return basicAuth;
  }

  Future<dynamic> sendDataToSAP(
      dynamic data, String username, String password) async {
    // final url = Uri.parse('$baseUrl/sap/zrest/mfg/gr_os'); // Ganti 'endpoint' dengan endpoint yang sesuai.
    // final response = await http.post(
    //   url,
    //   headers: <String, String>{
    //     'Content-Type': 'application/json',
    //     'Authorization': _basicAuth(),
    //   },
    //   body: jsonEncode(data),
    // );

    // if (response.statusCode == 200) {
    //   return response;
    // } else {
    //   throw Exception('Failed to send data to SAP');
    // }

    var _response;
    var dio = Dio();
    //
    dio.options
      ..baseUrl = baseUrl
      // ..connectTimeout = Duration(milliseconds: 1000)
      // ..receiveTimeout = Duration(milliseconds: 1000)
      // ..validateStatus = (int? status) {
      // return status! > 0;
      // }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        // HttpHeaders.authorizationHeader: _basicAuth(username, password),
      };

    _isLoadingSendSAP = true;
    notifyListeners();

    try {
      var responseData = await dio.post(
        "/sap/zrest/mfg/gr_os",
        data: data
//         {
//    "EXTERNAL_KEY" : "8",
//    "PARTNER_KEY" : "PRTL",
//    "USERNAME" : "SAP_API",
//    "TRX_TYPE" : "XXX_0001",
//    "DATA_HEADER" : {
//          "OS_NUMBER" : "1234567899",
//       "DN_SUP" : "DN12345",
//       "PSTNG_DATE" : "20240215"
//   },

//    "DATA_ITEM" : [
//       {
//          "LINE_ID" : "10",
//          "KANBAN_ID" : "12345678",
//          "QTY_SUP" : "1000",
//          "QTY_TERIMA" : "1000"
//        },
//     {
//          "LINE_ID" : "20",
//          "KANBAN_ID" : "12345679",
//          "QTY_SUP" : "1000",
//          "QTY_TERIMA" : "1000"
//       }
//    ]
//  }
,
        options: Options(
          headers: <String, String>{
            'Authorization': _basicAuth(username, password)
          },
          contentType: Headers.jsonContentType,
        ),
      );

      print("RESPONSE POST SEND TO SAP: $responseData");

      if (responseData.data != null) {
        _response = responseData.data;
        //
      } else {
        print("RESPONSE POST SEND TO SAP error: ${responseData.statusCode}");
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      // Something happened in setting up or sending the request that triggered an Error
      print(e.response);
    }

    _isLoadingSendSAP = false;
    notifyListeners();

    return _response;
  }
}
