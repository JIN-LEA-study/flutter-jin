import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp( // MaterialApp()을 밖으로 빼야 나중에 편하다.
          home : MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
