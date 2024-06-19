import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage ({super.key});

   @override
  _HomePage createState() => _HomePage();
}


class _HomePage extends State<HomePage>{
  late Timer _timer;
  int _delivery = 0;
  int _goodreceipt = 0;
  List<Map<String, dynamic>> data = [];
  late String username = '';

   @override
  void initState() {
    super.initState();
    _fetchDeliveryCount();
    _fetchActiveDelivery();
    _fetchGoodReceiptCount();
    _getUsername();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted){
      _fetchDeliveryCount();
      _fetchGoodReceiptCount();
      _fetchActiveDelivery();
      }
    });
  }

  Future<void> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'User';
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _fetchDeliveryCount() async {
    final response = await http.get(Uri.parse('http://10.14.90.223:44/api/Delivery'));
     if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        _delivery= jsonResponse['total_quantity'] ?? 0;
      });
    } else {
      setState(() {
        _delivery= 0; // Default value if request fails
      });
    }
  }

    Future<void> _fetchGoodReceiptCount() async {
    final response = await http.get(Uri.parse('http://10.14.90.223:44/api/GoodReceipt'));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        _goodreceipt = jsonResponse['total_quantity'] ?? 0;
      });
    } else {
      setState(() {
        _goodreceipt = 0; // Default value if request fails
      });
    }
  }

  Future<void> _fetchActiveDelivery() async {
    final response = await http.get(Uri.parse('http://10.14.90.223:44/api/ActiveDelivery'));
    if (response.statusCode == 200) {
      final String jsonString = response.body;
      final Map<String, dynamic> responseData = jsonDecode(jsonString);
      final List<dynamic> listActiveDelivery = responseData['listActiveDelivery'];
      setState(() {
        data = List<Map<String, dynamic>>.from(listActiveDelivery);
      });
    } else {
      setState(() {
        data = []; // Default value if request fails
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 328,
              height: 75,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 23, 41, 86),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                  children: <Widget>[
                  Padding(padding: EdgeInsets.only(top:6)),
                  Text(
                    'Welcome, $username',
                    style: TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  Padding(padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "PT Astra Otoparts Divisi NM",
                    style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 155,
                  height: 23,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text('Delivery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                  ),
                ),
                Container(
                  width: 155,
                  height: 23,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text('Good Receipt', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                  ),
                ),
              ],
            ),
            
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 155,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text('$_delivery'),
                  ),
                ),
                Container(
                  width: 155,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text('$_goodreceipt'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 10, top: 4),
              width: 328,
              height: 30,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 23, 41, 86),
                borderRadius: BorderRadius.circular(5),
              ),
              child: 
              Text('Active Delivery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),),
            ),

            
            Expanded(
              child: SingleChildScrollView(
               //scrollDirection: Axis.horizontal,
                child: DataTable(
                  dataTextStyle: TextStyle(fontSize: 10),
                  columnSpacing: 5,
                  horizontalMargin: 2,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'No. Surat Jalan',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Subcon',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'No. OS',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'No. QR',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    data.length,
                    (index) => DataRow(
                      color: index % 2 == 0 ? MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                      // Warna untuk baris genap
                      return Colors.blueGrey[50] ?? Colors.transparent;
                      }) : MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                      // Warna untuk baris ganjil
                      return Colors.transparent;
                      }),
                      cells: [
                        DataCell(Text(data[index]['No. Surat Jalan'].toString())),
                        DataCell(Text(data[index]['subcon'] ?? '')),
                        DataCell(Text(data[index]['No. OS'] ?? '')),
                        DataCell(Text(data[index]['No. QR'] ?? '')),
                      ],
                    ),
                  ),
                ),
              ),
              
            ),
            
            ],
            
        ),
        
      ),
      
    );
  }
}

