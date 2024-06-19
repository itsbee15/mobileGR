import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgotEmailWidget extends StatefulWidget{
  const ForgotEmailWidget ({Key? key}) : super(key: key);

  @override
  State<ForgotEmailWidget> createState() => _ForgotEmailWidgetState();
}

  class _ForgotEmailWidgetState extends State<ForgotEmailWidget> {
String email= '';

@override
Widget build (BuildContext context){
  return Container(
    alignment: Alignment.center,
    height: 43,
    width: 232,
    decoration: const BoxDecoration(
    color: Colors.white, 
    borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    child: TextField(
      cursorColor: Colors.black,
      autofocus: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey,),
                    borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 30, 53, 109),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
        hintText: 'Email',
        hintStyle: TextStyle(
          color: Colors.grey,
          ),
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: Colors.grey,
          ),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        email = value;
      },
    ),
  );
}
  }
