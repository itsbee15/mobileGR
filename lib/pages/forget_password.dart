
import 'package:first_flutter_project/components/forgot_button.dart';
import 'package:first_flutter_project/components/forgot_email.dart';
import 'package:flutter/material.dart';


class ForgetPassword extends StatefulWidget{
  const ForgetPassword ({super.key});

  @override
  _ForgetPassword createState() => _ForgetPassword();
  }

class _ForgetPassword extends State<ForgetPassword>{
 
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 23, 41, 86),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_circle_left_outlined),
          color: Colors.white, iconSize: 35,
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top:40),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top:10, left: 40, right: 40),
                child: const Text(
                  "Enter your email and we will send you a link to reset your password",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
                ),

            ),
            const SizedBox(height: 30,),
            const ForgotEmailWidget(),
            const SizedBox(height: 25,),
            const ForgotButtonWidget(),
          ],
        ),
      );
  }

  

}