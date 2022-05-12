import 'package:flutter/material.dart';
import 'style.dart';
// import 'style.dart' as style; 같이 작명가능 style.theme 이같은 방식으로 사용
// 다른 파일에 있는 변수, 함수 쓰고 싶으면 import'파일경로'부터
// import './style.dart'; - OK - './'는 현재 경로를 뜻한다.

void main() {
  runApp(
      MaterialApp( // MaterialApp()을 밖으로 빼야 나중에 편하다.
          theme: theme,
          home : MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      // body: Text('안녕', style: Theme.of(context).textTheme.bodyText1,) // ThemeData() 찾아서 거기 있던 textTheme>bodyText2 가져오기  // 원하는 ThemeData안의 내용 불러오기
      body: Text('안녕'),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label:'홈'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label:'샵'),
        ]
      ),
    );
  }
}
