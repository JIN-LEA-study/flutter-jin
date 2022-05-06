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

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // Flutter에서 앱 디자인 넣는 법 : 위젯 짜깁기
      home: Scaffold( // App을 상, 중, 하로 나눠준다.
        floatingActionButton: FloatingActionButton(
          child: Text(a.toString()), //a는 숫자니까 toString 작성
          // (현재 버튼을 눌러도 변화가 없는 이유는 재렌더링이 안되고 있기 때문이다.-console에는 잘 나온다.)
          onPressed: (){ // 버튼 눌렀을 때 코드 실행하려면 onPressed(){}
            print(a);
            // state 변경하려면 setState((){here})
            setState((){
              a++; // +1 해주세요
            });
          }, // 버튼 누르면 여기 코드를 실행한다.
        ),
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder:(c, i){
            return ListTile(
              leading: Image.asset('profile.png'),
              title: Text('홍길동'),
            );
          }
        )
      )
    );
  }
}