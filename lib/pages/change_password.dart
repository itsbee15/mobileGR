import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String currentPassword = '';
  String newPassword = '';
  String retypeNewPassword = '';
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
        backgroundColor: Color.fromARGB(255, 23, 41, 86),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_circle_left_outlined),
          color: Colors.white, iconSize: 35,
          ),
        title: Text('Profile', style: TextStyle(fontWeight:FontWeight.bold),), centerTitle: true, titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
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
            // Current password
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password'
              ),
              onChanged: (value) {
                setState(() {
                  currentPassword = value;
                });
              },
            ),
            // New password
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
              onChanged: (value) {
                setState(() {
                  newPassword = value;
                });
              },
            ),
            // Retype new password
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Retype New Password',
              ),
              onChanged: (value) {
                setState(() {
                  retypeNewPassword = value;
                });
              },
            ),
            // Button save data
            SizedBox(height: 30),
            TextButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 23, 41, 86))),
              onPressed: () {},
              child: Text('Save', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
