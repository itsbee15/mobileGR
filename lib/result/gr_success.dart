import 'package:first_flutter_project/model/model_surat_jalan.dart';
import 'package:first_flutter_project/pages/home_screen.dart';
import 'package:flutter/material.dart';

class GRSuccess extends StatefulWidget {
  final Map<String, dynamic> quantityMap;
  final NoSuratJalan selectedSuratJalan;
  const GRSuccess({Key? key, required this.quantityMap, required Map<String, dynamic> previousData, required this.selectedSuratJalan}) : super(key: key);

  @override
  State<GRSuccess> createState() => _GRSuccessState();
}

class _GRSuccessState extends State<GRSuccess> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomeScreen()));
          }, 
          child: Text('Done',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          ),
        ],
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
                  DataColumn(
                    label: Text('No. GR', 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                    ),
                ], 
                rows: widget.quantityMap.entries.map<DataRow>((entry) {
                final materialCode = entry.key;
                final totalQuantity = entry.value.toString();
                return DataRow(
                cells: <DataCell>[
                DataCell(Text(materialCode)),
                DataCell(Text(totalQuantity)),
                DataCell(Text("data")),
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
                  Text('GR SUCCESS', 
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.green),)
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