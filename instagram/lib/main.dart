import 'package:flutter/material.dart';
import 'style.dart';
// import 'style.dart' as style; 같이 작명가능 style.theme 이같은 방식으로 사용
// 다른 파일에 있는 변수, 함수 쓰고 싶으면 import'파일경로'부터
// import './style.dart'; - OK - './'는 현재 경로를 뜻한다.

void main() {
  runApp(
      MaterialApp( // MaterialApp()을 밖으로 빼야 나중에 편하다.
          theme: theme,
          home : MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Instagram'),
          actions: [
            IconButton(
              icon: Icon(Icons.add_box_outlined),
              onPressed: (){},
              iconSize: 30,
            )
          ]
      ),
      body: TextButton(onPressed: (){}, child: Text('안녕'),),
    );
  }
}
