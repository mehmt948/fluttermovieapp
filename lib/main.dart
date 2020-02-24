import 'package:flutter/material.dart';
import 'package:movie_gallery/screens/home.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Home()
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}