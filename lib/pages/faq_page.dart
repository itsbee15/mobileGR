import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 30, 53, 109),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_circle_left_outlined),
          color: Colors.white, iconSize: 35,
          ),
        title: Text('FAQ', style: TextStyle(fontWeight:FontWeight.bold),), 
        centerTitle: true, titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Column(
        
          children: <Widget>[
            Container(
              height: 160,
              width: 350,
              
              margin: EdgeInsets.only(top: 20, left: 32, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Bagaimana cara scan QR code?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "QR code dapat di scan dengan klik menu scan QR, lalu arahkan kamera pada QR code. Tunggu sampai QR code terbaca oleh sistem dan keluar hasil.",
                    style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,
                  ),
                  
                ],
              ),
            ),
            Container(
              height: 160,
              width: 350,
              
              margin: EdgeInsets.only(top: 10, left: 32, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  const Text(
                    "Bagaimana cara mengganti password jika tidak mengingat password lama?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  const Text(
                    "Logout aplikasi, kemudian klik forgot password. Klik send to email",
                    style: TextStyle(fontSize: 14), textAlign: TextAlign.justify,
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      );
    
  }
  }
