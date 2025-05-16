import 'package:flutter/material.dart';
import 'package:flutter_application_27/presentation/login_screen/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.light;
  void _setTheme() {
    setState(() {
      // нигер не нигер
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => login_screen(setl: _setTheme)},
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        primaryColor: Colors.white
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
          primaryColor: Colors.black
      ),
    );
  }
}
