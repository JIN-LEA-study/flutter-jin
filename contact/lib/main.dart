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
        body: Container(
          width: 150, height: 50,
          margin: EdgeInsets.all(20), // 바깥 여백 주고 싶으면, margin Parameter를 이용한다.
          // padding: EdgeInsets.fromLTRB(left, top, right, bottom),
          // padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          decoration: BoxDecoration( // 테두리 주고 싶으면 decoration Parameter를 준다.
            border: Border.all(color: Colors.black)
          )
        )
      )
    );
  }
}
