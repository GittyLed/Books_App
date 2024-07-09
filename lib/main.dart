import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Model/model.dart';
import 'Screen/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = true;

  void toggleDarkMode(){
    setState(() {
      isDarkMode =!isDarkMode;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode? ThemeData.dark() : ThemeData.light(),
      home: LoginPage(
        isDarkMode: isDarkMode,
        toggleTheme: toggleDarkMode,
      )
    );
  }
}

List<Book> cart = [];