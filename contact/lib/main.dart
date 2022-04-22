import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // 앱 구동 함수
}

// 아래 4줄은 세팅 문법
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // Flutter에서 앱 디자인 넣는 법 : 위젯 짜깁기
      home: Scaffold( // App을 상, 중, 하로 나눠준다.
        appBar: AppBar(),
        body: ListView( // ListView() 안에 넣으면 스크롤바 생성, 스크롤 위치 감시기능, 메모리 절약기능.
          children: [
            Text('안녕'),
            Text('안녕'),
            Text('안녕'),
            Text('안녕'),
            Text('안녕'),
          ],
        )
      )
    );
  }
}