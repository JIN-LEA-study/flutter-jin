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
        appBar: AppBar(title: Text('앱임')),
        body: Align(
          // alignment: Alignment.bottomCenter, // 하단
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity, height: 50, color: Colors.blue, // 박스 width를 가로로 꽉차게
          ),
        )
      )
    );
  }
}
