import 'package:flutter/material.dart';
// 기본 위젯들 쓰려면 필요하다

// 이 변수는 다른 파일로 안들어갔으면 좋겠다 - 변수를 다른 파일에 쓰기 싫으면 _변수명_함수명_클래스명
// 왼쪽 언더바를 사용하면 이 변수는 다른 파일에서 절대 쓸 수 없는 변수가 된다.

var theme = ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 1, // 그림자 크기
    titleTextStyle: TextStyle(color:Colors.black, fontSize: 25),
    actionsIconTheme: IconThemeData(color: Colors.black),
  ),
  textTheme: TextTheme(
      // bodyText2: TextStyle( color:Colors.red ), // 여기에 다양한 스타일 만들어 놓고 Theme.of() 이걸로 가져다 쓸 수도 있다.
  ),
);