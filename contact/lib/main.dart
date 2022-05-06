import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        home: MyApp())
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var a = 3;
  var name = ['김영숙', '홍길동', '피자집'];
  var like = [0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder:(c, i){
            return ListTile(
              leading: Image.asset('profile.png'),
              title: Text(name[i]),
            );
          },
        ),
        // 부모 -> 자식 state 전송 방법 1. 보내고 2. 등록하고 3. 사용
        floatingActionButton: FloatingActionButton(
              onPressed: (){
                showDialog(context: context, builder: (context){
                  return DialogUI(state : a, state2: 'melon');
                  // 1. 자식위젯 (작명: 보낼 state)
                });
              },
          ),
        );
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.state, this.state2 }) : super(key: key);
  final state;
  final state2;
  // state로 작명한 것을 line48, line49 두군데에 등록
  // var state; -> 다음과 같이 작성시 다른 const를 삭제해야한다 귀찮으면 final을 쓰는데 다만 final은 최종이라 수정이 안된다.
  // 부모가 보낸 state는 read-only 가 좋다. 그래서 final을 쓰는 것도 좋다.
  // 2. 등록은 2곳에
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField(),
            TextButton(onPressed: (){}, child: Text(state2.toString())),
            TextButton(onPressed: (){ Navigator.pop(context); }, child: Text('취소')) // 실행시 닫힘
          ],
        )
      )
    );
  }
}
