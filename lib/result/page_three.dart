import 'package:first_flutter_project/controller/SAPService.dart';
import 'package:first_flutter_project/model/model_surat_jalan.dart';
import 'package:first_flutter_project/result/gr_failed.dart';
import 'package:first_flutter_project/result/gr_success.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageThree extends StatefulWidget {
  final Map<String, dynamic> previousData;
  final NoSuratJalan selectedSuratJalan;

  const PageThree({Key? key, required this.previousData, required this.selectedSuratJalan}) : super(key: key);

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {

    Map<String, dynamic> quantityMap = {};
    final SAPService sapService = SAPService(
    'http://aoph1qappdc.aop.oto:8020',  // Ganti dengan URL dasar API SAP Anda.
    'SAP_API',       // Ganti dengan username Basic Auth Anda.
    'A-Otop@rts123',       // Ganti dengan password Basic Auth Anda.
  );

    @override
  void initState() {
    super.initState();
    _calculateQuantity();
  }

  void _calculateQuantity() {
    for (var item in widget.previousData['items']) {
      String materialCode = item['material_code'];
      int quantity = int.tryParse(item['quantity'] ?? '') ?? 0;
      quantityMap.update(materialCode, (value) => value + quantity, ifAbsent: () => quantity);
    }
  }

  void _sendData() async {
    try {
    final sapData = {
      "EXTERNAL_KEY": "8",
      "PARTNER_KEY": "PRTL",
      "USERNAME": "SAP_API",
      "TRX_TYPE": "XXX_0001",
      "DATA_HEADER": {
        "OS_NUMBER": widget.selectedSuratJalan.ShipmentLetterCodeAndCounter,
        "DN_SUP": "DN12345",
        "PSTNG_DATE": Text(DateFormat('yyyy MMMM dd').format(DateTime.now()),),
      },
      "DATA_ITEM": widget.previousData['items'].map((item) {
        return {
          "LINE_ID": item['line_id'] ?? "N/A",
          "KANBAN_ID": item['kanban_id'] ?? "N/A",
          "QTY_SUP": item['quantity'],
          "QTY_TERIMA": item['quantity - quantity_ng'],
        };
      }).toList(),
    };

    final response = await sapService.sendDataToSAP(sapData);

    if (response.statusCode == 200) {
      // Tampilkan pesan sukses atau navigasi ke halaman lain.
      Navigator.push(context, MaterialPageRoute(builder: (context) => GRSuccess(previousData: widget.previousData, quantityMap: quantityMap, selectedSuratJalan: widget.selectedSuratJalan,)));
    } else {
      // Tampilkan pesan kesalahan.
      Navigator.push(context, MaterialPageRoute(builder: (context) => GRFailed(selectedSuratJalan: widget.selectedSuratJalan,)));
    }
  } catch (e) {
    // Tangani kesalahan lain, misalnya kesalahan jaringan.
    throw Exception('Failed to load data to SAP');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 23, 41, 86),
        centerTitle: true,
        title: Text(
          "Scan GR Incoming",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(109, 187, 187, 187),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'No. Surat Jalan',
                                    style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.selectedSuratJalan.ShipmentLetterCodeAndCounter,
                                    style: TextStyle(fontSize: 12, color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: DataTable(
                  dataTextStyle: TextStyle(fontSize: 10),
                  columnSpacing: 20,
                  horizontalMargin: 20,
                  columns: const <DataColumn> [
                  DataColumn(
                    label: Text('Material Code', 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                    ),
                  DataColumn(
                    label: Text('Total Quantity', 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                    ),
                ], 
                rows: quantityMap.entries.map((entry) {
                    return DataRow(
                      cells: [
                        DataCell(Text(entry.key)),
                        DataCell(Text(entry.value.toString())),
                      ],
                    );
                  }).toList(),
                ),
              ),
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 23, 41, 86))),
                      onPressed: _sendData,
                    
                    child: Text('Send to SAP', style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
           ],
          ),
        ),
      ),
    );
  }
}