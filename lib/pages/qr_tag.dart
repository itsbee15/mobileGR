import 'package:first_flutter_project/model/model_surat_jalan.dart';
import 'package:first_flutter_project/pages/faq_page.dart';
import 'package:first_flutter_project/result/page_two.dart';
import 'package:first_flutter_project/services/main_model.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const bgColor = Color(0xfffafafa);

class QRTag extends StatefulWidget {
  final void Function(String OSNumber) onScan;
  final NoSuratJalan selectedSuratJalan;

  const QRTag(
      {super.key, required this.onScan, required this.selectedSuratJalan});

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
  String? accessToken;

  @override
  void initState() {
    super.initState();
    _loadAccessToken();
  }

  Future<void> _loadAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('access_token');
    });
  }

  void resetScanState() {
    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        isScanCompleted = false;
      });
    });
  }

  void _handleScan(String qrTagNumber, MainModel model) {
    if (accessToken != null) {
      widget.onScan(qrTagNumber);
      model.addingQRtoTag(qrTagNumber);
      //
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageTwo(
            qrTagNumber: qrTagNumber,
            selectedSuratJalan: widget.selectedSuratJalan,
          ),
        ),
      );
    } else {
      // Handle case when access token is not available
      print("Access token is not available.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return Scaffold(
          backgroundColor: bgColor,
          drawer: const Drawer(),
          appBar: AppBar(
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  String qrTagNumber = _textFieldController.text;
                  _handleScan(qrTagNumber, model);
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            iconTheme: const IconThemeData(color: Colors.black87),
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 23, 41, 86),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_circle_left_outlined),
              color: Colors.white,
              iconSize: 35,
            ),
            centerTitle: true,
            title: const Text(
              "QR Tag Lot",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.only(left: 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isFlashOn = !isFlashOn;
                              });
                              controller.toggleTorch();
                            },
                            icon: Icon(
                              Icons.flash_on,
                              color: isFlashOn ? Colors.blue : Colors.grey[800],
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.grey[300]),
                            ),
                          ),
                          SizedBox(width: 15),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FAQPage()));
                            },
                            icon: Icon(
                              Icons.question_answer,
                              color: Colors.grey[800],
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.grey[300]),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 20),
                  Text(
                    "Scan QR code here",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      width: 300,
                      height: 300,
                      child: Stack(
                        children: [
                          MobileScanner(
                            controller: controller,
                            allowDuplicates: true,
                            onDetect: (barcode, args) {
                              if (!isScanCompleted) {
                                Future.delayed(Duration(milliseconds: 500), () {
                                  setState(() {
                                    _textFieldController.text =
                                        barcode.rawValue ?? '---';
                                    isScanCompleted = true;
                                    lastScannedBarcode = barcode.rawValue!;
                                  });
                                  resetScanState();
                                });
                              } else {
                                if (barcode.rawValue == lastScannedBarcode) {
                                  controller.stop();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: const Text(
                                          "QR Code Duplicated!",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 14),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              controller.start();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
                                    setState(() {
                                      _textFieldController.text =
                                          barcode.rawValue ?? '---';
                                      lastScannedBarcode = barcode.rawValue!;
                                    });
                                  });
                                }
                              }
                            },
                          ),
                          QRScannerOverlay(overlayColor: Colors.transparent),
                        ],
                      )),
                  const SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          " No. QR Tag",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: _textFieldController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: 'Input QR Tag number here',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
