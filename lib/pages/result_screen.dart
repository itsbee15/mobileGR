
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultScreen extends StatelessWidget {
final String code;
final Function() closeScreen;

  const ResultScreen({super.key, required this.closeScreen, required this.code});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Scan GR Incoming",
              style: TextStyle(color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              ),
              ),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 30, right: 25),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            QrImageView(
                data: "",
              size: 300,
              version: QrVersions.auto,
            ),

            Text("Scan Result",
              style: TextStyle(color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              ),
              ),
              SizedBox(height: 10),
              Text(code,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,
              fontSize: 18,
              letterSpacing: 1,
              ),
              ),
              
          ],
        ),
      ),
    );
  }
  

}