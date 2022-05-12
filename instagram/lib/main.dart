import 'package:flutter/material.dart';
import 'style.dart';
// import 'style.dart' as style; 같이 작명가능 style.theme 이같은 방식으로 사용
// 다른 파일에 있는 변수, 함수 쓰고 싶으면 import'파일경로'부터
// import './style.dart'; - OK - './'는 현재 경로를 뜻한다.

void main() {
  runApp(
      MaterialApp(
          theme: theme,
          home : MyApp()
      )
  );
}

// 동적인 UI 만드는 법
// 1. state에 tab의 현재 상태 저장
// 2. state에 따라 tab이 어떻게 보일지 작성
// 3. 유저가 쉽게 state 조작할 수 있게 -> 누르면 state 바뀌는 버튼 만들기

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
} // 여기까지 5줄 무시

class _MyAppState extends State<MyApp> {
  var tab = 1;

  // state가 0이면, Text('홈')
  // state가 1이면, Text('샵')

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
      // body: [Text('홈페이지'),Text('샵페이지')][1],
      body: [Text('홈페이지'), Text('샵페이지')][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap:(i){
          // print(i);
          setState(() {
            tab = i;
          });
        }, // 기본적으로 파라미터 작성하게 되어있다. i는 지금 누른 버튼 번호
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label:'홈'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label:'샵'),
        ]
      ),
    );
  }
}
