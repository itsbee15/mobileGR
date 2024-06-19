import 'package:first_flutter_project/model/model_surat_jalan.dart';
import 'package:first_flutter_project/pages/qr_tag.dart';
import 'package:first_flutter_project/result/page_three.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  String qrTagNumber;
  final NoSuratJalan selectedSuratJalan;

  PageTwo({Key? key, required this.qrTagNumber, required this.selectedSuratJalan}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  List<Map<String, dynamic>> data = [];

@override
  void initState() {
    super.initState();
    _addData({
      'no_qr_tag': '',
      'material_code': widget.qrTagNumber.split('|')[2],
      'quantity': widget.qrTagNumber.split('|')[3],
      'quantity_ng': '', // Initial value for QTY NG, you can adjust this as needed
    });
  }

  Future<void> _showEditDialog(BuildContext context, String initialValue, Function(String) onChanged) async {
    String? editedValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String newValue = initialValue;
        return AlertDialog(
          title: Text('New Value'),
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
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(newValue);
              },
              child: Text('Save'),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: 
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: DataTable(
                  dataTextStyle: TextStyle(fontSize: 10),
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
                                    _showEditDialog(context, widget.qrTagNumber.split('|').elementAt(3), (newValue) {
                                      setState(() {
                                        List<String> newQrTagNumber = widget.qrTagNumber.split('|');
                                        newQrTagNumber[3] = newValue;
                                        widget.qrTagNumber = newQrTagNumber.join('|');
                                      
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
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 23, 41, 86))),
                    onPressed: () {
                      // Pindah ke halaman send to SAP
                      Map<String, dynamic> previousData = {
                          'items': data,
                        };
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PageThree(previousData: previousData, selectedSuratJalan: widget.selectedSuratJalan,)));
                    },
                    child: Text('Save', style: TextStyle(color: Colors.white),),
                  ),
                  TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 23, 41, 86))),
                    onPressed: () {
                      // Pindah ke halaman scan
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> QRTag(onScan: (String osNumber) {}, selectedSuratJalan: widget.selectedSuratJalan))).then((result) {
                        if (result != null) {
                          setState(() {
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