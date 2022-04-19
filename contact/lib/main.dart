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
      home: Center(
        child: Container(width : 50, height : 50, color: Colors.blue),
      ) // 사이즈 단위는 LP 50LP==1.2cm(얇은 검지손가락)
      // home: Text('안녕')
      // home: Icon(Icons.shop)
      // home: Image.asset('assets/dog.jpg')

    );
  }
}
