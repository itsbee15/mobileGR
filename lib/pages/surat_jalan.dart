import 'package:first_flutter_project/model/model_surat_jalan.dart';
import 'package:first_flutter_project/pages/qr_tag.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_project/controller/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuratJalan extends StatefulWidget {
  final List<NoSuratJalan> suratJalanList;


  const SuratJalan({Key? key, required this.suratJalanList}) : super(key: key);

  @override
  _SuratJalanState createState() => _SuratJalanState();
}

class _SuratJalanState extends State<SuratJalan> {

List<NoSuratJalan> nosuratjalanList = [];
NoSuratJalan? selectedSuratJalan;

@override
  void initState() {
    super.initState();
    nosuratjalanList = widget.suratJalanList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(onPressed: selectedSuratJalan != null? (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> QRTag(onScan: _handleScan, selectedSuratJalan: selectedSuratJalan!)));
          }: null, 
          child: Text('Done',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 23, 41, 86),
        leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_circle_left_outlined),
          color: Colors.white, iconSize: 35,
          ),
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 20),
            _nosuratjalan(),
            _answerList(),
          ],
        ),
      ),
    );
  }

  void _handleScan(String OSNumber) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    if (accessToken == null) {
      // Handle the case when access token is not available
      throw Exception('Access token not found');
    }
    ApiService.fetchSuratJalan(OSNumber, accessToken).then((list) {
      setState(() {
        nosuratjalanList = list;
      });
    }).catchError((error) {
      // Handle error
    });
  }

 Widget _nosuratjalan(){
    if (nosuratjalanList.isEmpty) {
      return Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsetsDirectional.all(20),
        decoration: BoxDecoration(
          color: Color.fromARGB(109, 187, 187, 187),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          "No. Surat Jalan",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsetsDirectional.all(20),
          decoration: BoxDecoration(
          color: Color.fromARGB(109, 187, 187, 187),
          borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            "No. Surat Jalan", 
            style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ],
    );

    }
    Widget _answerList(){
      if (nosuratjalanList.isEmpty) return Container();

    return Column(
      children: nosuratjalanList.map((e) => _answerButton(e)).toList(),
    );
  }

    Widget _answerButton(NoSuratJalan suratJalan) {
    bool isSelected = suratJalan == selectedSuratJalan;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
        child: Text(suratJalan.ShipmentLetterCodeAndCounter),
        style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.black, 
        backgroundColor: isSelected ? Colors.grey : Colors.white, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        ),
        onPressed: () {
          
            setState(() {
              selectedSuratJalan = suratJalan;
            });
          
        },
      ),
    );
  }
}