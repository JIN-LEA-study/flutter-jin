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
        body: Text('안녕'),
        bottomNavigationBar: BottomAppBar(
        // child: Container( // Container는 무거운 박스라서 Lint가 잡아준다. (밑줄생김)
        child: SizedBox( // width, height, child만 필요한 박스는 SizedBox()
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // Row 안에서 정렬한다. (mainAxisAlignment)
              children: [
                Icon(Icons.phone),
                Icon(Icons.message),
                Icon(Icons.contact_page),
              ],
            ),
          ),
        ),
      ) // 사이즈 단위는 LP 50LP==1.2cm(얇은 검지손가락)
      // home: Center(
      // child: Container(width : 50, height : 50, color: Colors.blue),
      // home: Text('안녕')
      // home: Icon(Icons.shop)
      // home: Image.asset('assets/dog.jpg')
    );
  }
}
