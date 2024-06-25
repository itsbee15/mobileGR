import 'package:first_flutter_project/controller/api_service.dart';
import 'package:first_flutter_project/model/model_surat_jalan.dart';
import 'package:first_flutter_project/pages/qr_tag.dart';
import 'package:first_flutter_project/result/page_three.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageTwo extends StatefulWidget {
  String qrTagNumber;
  final NoSuratJalan selectedSuratJalan;

  PageTwo({Key? key, required this.qrTagNumber, required this.selectedSuratJalan}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  List<Map<String, dynamic>> data = [];
  String? accessToken;

@override
  void initState() {
    super.initState();
    _loadAccessToken();
    _fetchData();
    
  }

  Future<void> _loadAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('access_token');
    });
  }

  Future<void> _fetchData() async {
    // if (accessToken != null) {
    //   // Fetch data from the API if needed
    //   final fetchedData = await ApiService.fetchData(widget.selectedSuratJalan, accessToken);
    //   setState(() {
    //     data = fetchedData;
    //   });
    // } else {
    //   // Handle case when access token is not available
    //   print("Access token is not available.");
    // }
  }

  Future<void> _showEditDialog(BuildContext context, String initialValue, Function(String) onChanged) async {
    String? editedValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String newValue = initialValue;
        return AlertDialog(
          title: const Text('New Value'),
          content: TextFormField(
            initialValue: initialValue,
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(newValue);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    // Jika nilai disimpan, panggil fungsi callback untuk memperbarui nilai data
    if (editedValue != null) {
      onChanged(editedValue);
    }
  }

  // Fungsi untuk menghapus baris data
  void _deleteRow(int index) {
    setState(() {
      data.removeAt(index);
    });
  }

  void _addData(Map<String, dynamic> newData) {
  setState(() {
    data.add(newData);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 23, 41, 86),
        centerTitle: true,
        title: const Text(
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
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(109, 187, 187, 187),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
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
                                    style: const TextStyle(fontSize: 12, color: Colors.black),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: 
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: DataTable(
                  dataTextStyle: const TextStyle(fontSize: 10),
                  columnSpacing: 10,
                  horizontalMargin: 2,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'QR Tag',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text(
                        'Material Code',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text(
                        'QTY',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text(
                        'QTY NG',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                      numeric: false,
                    ),

                    DataColumn(
                      label: Text(''),
                    )
                  ],
                  rows: List.generate(
                    data.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text(data[index]['no_qr_tag'])),
                          DataCell(Text('${widget.qrTagNumber.split('|').elementAt(2)}')),
                          DataCell(
                            Row(
                              children: [
                                Text(('${widget.qrTagNumber.split('|').elementAt(3)}')),
                                IconButton(
                                  iconSize: 20,
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _showEditDialog(context,data[index]['quantity'], (newValue) {
                                      setState(() {
                                        data[index]['quantity'] = newValue;
                                      
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              Text(data[index]['quantity_ng']),
                              IconButton(
                                iconSize: 20,
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _showEditDialog(context, data[index]['quantity_ng'], (newValue) {
                                    setState(() {
                                      data[index]['quantity_ng'] = newValue;
                                      
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        DataCell(
                          IconButton(
                            iconSize: 20,
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              // Tampilkan dialog konfirmasi sebelum menghapus
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text('Are you sure you want to delete this QR Tag Result?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel', style: TextStyle(color: Colors.black),),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _deleteRow(index);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Delete', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 23, 41, 86))),
                    onPressed: () {
                      // Pindah ke halaman send to SAP
                      Map<String, dynamic> previousData = 
                      {'items': data};
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PageThree(previousData: previousData, selectedSuratJalan: widget.selectedSuratJalan,)));
                    },
                    child: const Text('Save', style: TextStyle(color: Colors.white),),
                  ),
                  TextButton(
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 23, 41, 86))),
                    onPressed: () {
                      // Pindah ke halaman scan
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> QRTag(onScan: (String osNumber) {}, selectedSuratJalan: widget.selectedSuratJalan))).then((result) {
                        if (result != null) {
                          setState(() {
                            widget.qrTagNumber = result;
                            // Menambahkan data QR Tag yang baru discan
                              _addData({
                                'no_qr_tag': result.split('|')[0],
                                'material_code': result.split('|')[2],
                                'quantity': result.split('|')[3],
                                'quantity_ng': '', // Initial value for QTY NG
                          });
                          });
                        }
                      });

                    },
                    child: Text('Scan', style: TextStyle(color: Colors.white),),
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