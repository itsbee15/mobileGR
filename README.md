# first_flutter_project

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


import 'package:flutter/material.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

    @override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Flutter Demo',
theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fun Demo'),
    );
}
}

class MyHomePage extends StatefulWidget {
const MyHomePage({super.key, required this.title});

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

final String title;

@override
State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


@override
Widget build(BuildContext context) {
// This method is rerun every time setState is called, for instance as done
// by the _incrementCounter method above.
//
// The Flutter framework has been optimized to make rerunning build methods
// fast, so that you can just rebuild anything that needs updating rather
// than having to individually change instances of widgets.
return Scaffold(
appBar: AppBar(
// TRY THIS: Try changing the color here to a specific color (to
// Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
// change color while the other colors stay the same.
backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// Here we take the value from the MyHomePage object that was created by
// the App.build method, and use it to set our appbar title.
title: Text(widget.title),
),
body: const Center(
child: Text('Welcome'),
),
floatingActionButton: FloatingActionButton(onPressed: () {},
child: const Icon(Icons.add),
),
floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
drawer: Drawer(
child: ListView(
children: <Widget>[
const DrawerHeader(decoration: BoxDecoration(color: Colors.orange,
), child: Text('Beranda')
),
ListTile(
title: const Text('Riwayat Good Recipe'),
onTap: () {
Navigator.pop(context);
},
),
ListTile(
title: const Text('Profil'),
onTap: () {
Navigator.pop(context);
},
),
],
),
),
bottomNavigationBar: BottomNavigationBar(
items: const [
BottomNavigationBarItem(icon: Icon(Icons.home),
label: 'Beranda',
),
BottomNavigationBarItem(icon: Icon(Icons.history),
label: 'Riwayat',
),
BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),
label: 'Profil',
),

       ],
    
      ),

        );
}
}
