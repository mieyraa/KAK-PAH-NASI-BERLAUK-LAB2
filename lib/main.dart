import 'package:flutter/material.dart';
import 'package:kakpahnasiberlauk/view/splashpage.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Georgio',
        textTheme: const TextTheme(
          headline6: TextStyle(fontSize: 24.0),
          bodyText1: TextStyle(
            fontSize: 20.0, fontFamily: 'Hind', color: Colors.red),
        ),
      ),
      title: 'MyPasar',
      home: const Scaffold(
        body: SplashPage(),
      ));
  }
}