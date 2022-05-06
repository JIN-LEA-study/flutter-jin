import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        home: MyApp())
  );
}

// MyApp이라는 customWidget 바깥으로 MaterialApp()을 보낸다
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var a = 1;
  var name = ['김영숙', '홍길동', '피자집'];
  var like = [0, 0, 0];

  @override
  build(context) {
  // build(jokbo) {

    return Scaffold( // 보통 첫 페이지는 Scaffold()부터 시작
        floatingActionButton: Builder( //Builder 족보 생성기
          builder: (jokbo1) { // Scaffold, MaterialApp 이런게 들어있다.
            return FloatingActionButton(
              onPressed: (){ // 두 파라미터(context, builder)를 채워줘야 한다.
                // print(context.findAncestorWidgetOfExactType<MaterialApp>()); //context에 MaterialApp이 있는지 확인
                showDialog(context: context, builder: (context){
                // showDialog(context: jokbo, builder: (context){
                // context는 customWidget을 만들때마다 강제로 하나씩 생성된다.
                // context 구글 정의: The build location of the current widget.
                // 부모 위젯의 정보를 담고 있는 변수 (형제없는 족보)
                // showDialog(context) Scaffold.of(context)
                // Navigator.pop(context) Theme.of(context) - context입력해야 동작하는 함수들
                  return Dialog(child: Text('안녕'));
                });
              },
            );
          }
        ),
        appBar: AppBar(),
        // body: Dialog(child: Text('Dialog'),) // Dialog() 사용
        body:ListView.builder(
          itemCount: 3,
          itemBuilder:(c, i){
            return ListTile(
              leading: Image.asset('profile.png'),
              title: Text(name[i]),
            );
          }
      )
    );
  }
}