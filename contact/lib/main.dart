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
        body: ShopItem(),
      )
    );
  }
}
// 커스텀 위젯 만들기
// stless + tab
// class를 복사해서 새로운 class 만들고 싶으면 extends 키워드 쓰면 된다.
// 복사하기 좋은 완성된 위젯 class가 StatelessWidget 이라는 것이고
// 그걸 복사하면 커스텀 위젯 쉽게 만들 수 있다.
// class 작명 extends StatelessWidget {}
class ShopItem extends StatelessWidget {
  const ShopItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text('안녕'),
    );
  }
}
