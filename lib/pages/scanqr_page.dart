import 'package:first_flutter_project/pages/faq_page.dart';
import 'package:first_flutter_project/pages/surat_jalan.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:first_flutter_project/model/model_surat_jalan.dart';
import 'package:first_flutter_project/controller/api_service.dart';

const bgColor = Color(0xfffafafa);

class ScanQrPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
final TextEditingController _textFieldController = TextEditingController();
bool isScanCompleted = false;
bool isFlashOn = false;
MobileScannerController controller = MobileScannerController();

void closeScreen(){
  isScanCompleted = false;
}

void _handleScan(String OSNumber) async {
    try {
      List<NoSuratJalan> listSuratJalan = await ApiService.fetchSuratJalan(OSNumber);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuratJalan(suratJalanList: listSuratJalan),
        ),
      );
    } catch (error) {
      // Handle error
      print("Failed to fetch Surat Jalan: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: const Drawer() ,
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _handleScan(_textFieldController.text);
            },
            child: Text(
              'Done',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black87),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 23, 41, 86),
        centerTitle: true,
        title: Text("Order Sheet",
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
              Text("Scan Order Sheet here",
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
                  _textFieldController.text = barcode.rawValue?? '---';
                  isScanCompleted = true;
                }
                },
                ),
                QRScannerOverlay(overlayColor: Colors.transparent),
                ],
              ),
            ),
            SizedBox(height: 5),
            Flexible(
              flex: 2,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
              Text(" No. Order Sheet",
              style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold,
              ),
              ),
              
                  TextField(
                  controller: _textFieldController,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 2.0),
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
                      hintText: 'Input order sheet number here',
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