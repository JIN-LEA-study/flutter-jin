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
        body: Row(
          children : [
            Expanded( child: Container(color : Colors.blue), flex : 1 ),
            Container( color : Colors.green, width : 100 ),
            // 박스 폭을 50%로 설정하려면 Flexible()로 감싼다.
            // Flexible( child: Container(color : Colors.blue), flex : 3 ),
            // Flexible( child: Container(color : Colors.green), flex : 7 ),

            // console => alt + 4
            ],
        )
      )
    );
  }
}
