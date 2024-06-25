import 'package:first_flutter_project/pages/forget_password.dart';
import 'package:first_flutter_project/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';




class LoginPage extends StatefulWidget {
const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

Future<void> _login() async {
  final String username = usernameController.text;
  final String password = passwordController.text;
  final String grant_type = 'password';

    try {
      final response = await http.post(
        Uri.parse('http://10.14.90.223:44/api/Login'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'username=${Uri.encodeComponent(username)}&password=${Uri.encodeComponent(password)}&grant_type=${Uri.encodeComponent(grant_type)}',
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['access_token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid username or password'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login failed: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color.fromARGB(218, 207, 216, 220),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(180),
                  bottomRight: Radius.circular(180),
                ),
              ),
              child: Center(
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: 
                    AssetImage("lib/images/astra.png"),
                    height: 70,
                    ),
                    SizedBox(height: 5),
                    Text("Good Receipt Mobile Application", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12,),
            ),
                  ],
                ),
                ),
                ),

            SizedBox(height: 20),
            Text("SIGN IN", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),

            SizedBox(height: 15),

            //email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 30, 53, 109),),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 30, 53, 109),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Username',
                  prefixIcon: const Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),),
              
              SizedBox(height: 10),

              //password
               Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 30, 53, 109)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 30, 53, 109),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Password',
                  prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ForgetPassword();
                      }
                        ),
                        );
                      },
                      child: Text('Forgot password?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 23, 41, 86),
                        
                      ),),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),

              //login button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120.0),
                child: GestureDetector(
                onTap: () {
                _login();
                
                },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 23, 41, 86),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text('Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),),
                    ),
                  ),
                ),)

          ],
        ),
      ))
    );
}
}