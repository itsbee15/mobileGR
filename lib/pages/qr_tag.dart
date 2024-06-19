import 'package:first_flutter_project/model/model_surat_jalan.dart';
import 'package:first_flutter_project/pages/faq_page.dart';
import 'package:first_flutter_project/result/page_two.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';


const bgColor = Color(0xfffafafa);

class QRTag extends StatefulWidget {
  final void Function(String OSNumber) onScan;
  final NoSuratJalan selectedSuratJalan;

  const QRTag({super.key, required this.onScan, required this.selectedSuratJalan});

  @override
  State<StatefulWidget> createState() => _QRTagState();
}

class _QRTagState extends State<QRTag> {
final TextEditingController _textFieldController = TextEditingController();
bool isScanCompleted = false;
bool isFlashOn = false;
bool isFrontCamera = false;
MobileScannerController controller = MobileScannerController();
String? lastScannedBarcode;

void closeScreen(){
  isScanCompleted = false;
}

void resetScanState() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isScanCompleted = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: const Drawer() ,
      appBar: AppBar(
        actions: <Widget>[
          TextButton(onPressed: (){
            String qrTagNumber = _textFieldController.text;
            Navigator.push(context, MaterialPageRoute(builder: (context)=> PageTwo(qrTagNumber: qrTagNumber, selectedSuratJalan: widget.selectedSuratJalan,)));
          }, 
          child: Text('Done',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black87),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 23, 41, 86),
        leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_circle_left_outlined),
          color: Colors.white, iconSize: 35,
          ),
        centerTitle: true,
        title: Text("QR Tag Lot",
              style: TextStyle(color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              ),
              ),
      ),
      body: Container(
        width: 300,
        margin: EdgeInsets.only(left: 30),
        child: Column(
          children: [
            Positioned(
            child: Row(
              children: [
                IconButton(onPressed: (){
            setState(() {
              isFlashOn = !isFlashOn;
              
            });
            controller.toggleTorch();
          }, icon: Icon(Icons.flash_on, color:isFlashOn ? Colors.blue: Colors.grey[800],),
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey[300])),),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> FAQPage()));
          }, icon: Icon(Icons.question_answer, color: Colors.grey[800],),
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey[300])),),
              ],
            ),
          ),
            Expanded(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center ,
              children: [
              Text("Scan QR code here",
              style: TextStyle(color: Colors.black,
              
              fontWeight: FontWeight.bold,
              ),
              ),
              ],
              ),
              ), 

            Expanded(
              flex: 3,
              child: Stack(
                children: [
                MobileScanner(
                controller: controller,
                allowDuplicates: true,
                onDetect: (barcode,args){
                if(!isScanCompleted){
                setState(() {
                _textFieldController.text = barcode.rawValue ?? '---';
                isScanCompleted = true;
                lastScannedBarcode = barcode.rawValue!;
                
              });
              resetScanState();
  } else {
                  if (barcode.rawValue == lastScannedBarcode) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("QR Code Duplicated!", style: TextStyle(color: Colors.red, fontSize: 14)),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Show the new scanned QR Code
        _textFieldController.text = barcode.rawValue ?? '---';
        lastScannedBarcode = barcode.rawValue!;
      }
    }
  },
                ),
                QRScannerOverlay(overlayColor: Colors.transparent),
                ],
              )
            ),
            SizedBox(height: 5),
            Expanded(
              flex: 2,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
              Text(" No. QR Tag",
              style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold,
              ),
              ),
                  TextField(
                  controller: _textFieldController,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,),
                      borderRadius: BorderRadius.circular(5),
                    ),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                      hintText: 'Input QR Tag number here',
                  ),
                ),
              
              ],
              ),
              ),
          ],
        ),
      ),
    );
  }
}