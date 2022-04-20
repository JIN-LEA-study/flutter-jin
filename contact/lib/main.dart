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
        body: Container(
          height: 150,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Image.asset('dog.jpg', width: 150),
              Container(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // x축 정렬
                  children: [
                    Text('코인팝니다', style: TextStyle()),
                    Text('중구'),
                    Text('10,000원'),
                    Row(
                    // 하트 Icon 우측 이동 => Row안에서 mainAxis정렬
                      mainAxisAlignment: MainAxisAlignment.end, // Row안에서 가로축(x) 정렬
                      children: [
                        Icon(Icons.favorite),
                        Text('4'),
                      ],
                    )
                  ],
                )
              )
            ]
          )
        )
      )
    );
  }
}
