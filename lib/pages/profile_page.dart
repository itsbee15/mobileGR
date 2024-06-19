import 'package:first_flutter_project/pages/change_password.dart';
import 'package:first_flutter_project/pages/faq_page.dart';
import 'package:first_flutter_project/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String username = '';

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  Future<void> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'User';
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.question_answer, color: Colors.white,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FAQPage()),
            );
          },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 23, 41, 86),
        title: Text('Profile', style: TextStyle(fontWeight:FontWeight.bold),), 
        centerTitle: true, titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            // Gambar circle avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue[100],
              //backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            // Nama user
            SizedBox(height: 10),
            Text(
              username,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Bagian user
            SizedBox(height: 5),
            Text('Operator Finishing Internal', style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
            // Tampilan email user
            SizedBox(height: 15),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email', style: TextStyle(fontSize: 14),),
              subtitle: Text('emailuser@domain.com', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
            ),
            // Tampilan bussiness unit user
            
            ListTile(
              leading: Icon(Icons.business),
              title: Text('Bussiness Unit', style: TextStyle(fontSize: 14),),
              subtitle: Text('PT Astra Otoparts Divisi NM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
            ),

            //ubah password
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child:GestureDetector(
                        onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ChangePassword();
                         }
                         ),
                         );
                        },
                        child: Text("Change Password",
                               style: TextStyle(
                               color: Colors.blue,
                               fontSize: 14,
                               fontWeight: FontWeight.bold,
                        ),
                        ),
                        ),
                        ),
                        ),
                    Expanded(
                    child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: GestureDetector(
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                    return LoginPage();
                    }));
                    },
                    child: Text(
                    "Logout",
                    style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right, // Mengatur teks ke kanan
                    ),
                  ),
                  ),
                  ),
                ],
                ),
              ],
            ),
        ),
      );
  }
}
