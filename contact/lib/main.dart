import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // 앱 구동 함수
}

// stful + Tab키
// state는 StatefulWidget 안에서만 생성 가능
// state 생성 방법 1.
// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   State<Test> createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }


// state 생성 방법 2.
// StatelessWidget을 StatefulWidget으로 변환 (전구 -> Convert to StatefulWidget)
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var a = 1;
  var name = ['김영숙', '홍길동', '피자집'];
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold( // App을 상, 중, 하로 나눠준다.
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder:(c, i){
            return ListTile(
              leading: Image.asset('profile.png'),
              title: Text(name[i]),
            );
          }
        )
      )
    );
  }
}