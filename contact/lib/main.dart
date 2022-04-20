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
        appBar: AppBar(
            title : Text('앱제목'), // title: 제목
            leading : Icon(Icons.star), // leading: 제목 왼쪽 아이콘
            actions : [ Icon(Icons.star,color: Colors.deepPurpleAccent), Icon(Icons.star, color: Colors.lightGreenAccent,) ]), //actions: 제목 오른쪽 아이콘들
          body: SizedBox(
          // 가로 박스는 Row, 세로 박스는 Column.
          // IconButton
          // child: IconButton(
          //   icon: Icon(Icons.star, color: Colors.yellow, size: 100 ),
          //   onPressed:(){}, // 파라미터는 버튼 눌렀을 때 실행해줄 코드(함수) 작성
          // )

          // ElevatedButton
          // child: ElevatedButton(
          //   child: Text('글자'),
          //   onPressed:(){},
          //   style: ButtonStyle(),
          // )

          // TextButton
          // child: TextButton(
          // child: Text('글자'),
          // onPressed:(){},
          // style: ButtonStyle(),
          // )

          // child: Icon(Icons.star, color: Colors.yellow, size: 100),

          // child: Text('안녕하세요', // 각각의 Parameter는 ,를 꼭 찍는다.
          //   style: TextStyle( color: Color(0xff8057ff), fontWeight: FontWeight.w700), // 색상 1. Colors.컬러명 2. Color(0xffaaaaaa)
          // ),
        )
      )
    );
  }
}
