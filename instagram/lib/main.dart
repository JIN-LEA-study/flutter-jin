import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp( // MaterialApp()을 밖으로 빼야 나중에 편하다.
          theme: ThemeData(
            // ThemeData 사용시 특징 1. 위젯은 나랑 가까운 스타일을 가장 먼저 적용
            // ThemeData 사용시 특징 2. 복잡한 위젯은 복잡한위젯Theme()안에서 스타일줘야할 수도 (여기서 아이콘 스타일 줘봤자 AppBar안은 불가능)
            iconTheme: IconThemeData( color: Colors.blue ),
            appBarTheme: AppBarTheme(
                color: Colors.grey,
                actionsIconTheme: IconThemeData( color: Colors.blue )
            ),
            textTheme: TextTheme(
              bodyText2: TextStyle( color:Colors.red )
            ),
          ), // 스타일 모아놓는 ThemeData() <style></style> 스타일태그나 css파일 같은 부류
          home : MyApp()
      )
  );
}

// Text() 위젯 스타일 결정하고 싶다면
// Text()는 bodyText2 가져다 쓰고
// ListTile()은 subtitle1 가져다 쓰고
// TextButton()은 button 가져다 쓰고
// AppBar()은 headline6 가져다 쓰고
// 전체스타일을 주고싶다 -> 위와 같이 사용
// but, 이렇게 하면 복잡하다
// 그냥 변수로 축약해서 쓰는게 낫다

var a = TextStyle();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( actions: [Icon(Icons.star)] ),
      // body: Text('안녕', style: TextStyle(),), // 직접 입력하는 방식
      body: Text('안녕', style: a ), // 변수로 축약해서 사용하는 방식
    );
  }
}
