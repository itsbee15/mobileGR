import 'package:flutter/material.dart';

class ForgotButtonWidget extends StatefulWidget{
  const ForgotButtonWidget ({Key ? key}) : super(key: key);

  @override
  _ForgotButtonWidgetState createState() => _ForgotButtonWidgetState();
}

class _ForgotButtonWidgetState extends State<ForgotButtonWidget> {
  @override
  Widget build(BuildContext context){
    return TextButton(onPressed: (){},
     child: Container(
      alignment: Alignment.center,
      height: 45,
      width: 150,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 23, 41, 86),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            child: const Text("Submit",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),),
          ),
          
        ],
      ),
     ),);


  }
}