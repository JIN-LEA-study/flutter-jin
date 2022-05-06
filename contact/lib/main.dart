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
  var a = 1;
  var total = 3;
  var name = ['김영숙', '홍길동', '피자집'];
  var like = [0, 0, 0];

  // 부모 state를 자식이 수정하려면?
  // 1. 수정함수 2. state 보내고 3. 등록하고 4. 사용
  // 1. 부모안에 수정함수를 만든다. (state 조작하는 함수를 부모 위젯에 미리 만든다.)
  addOne(){
    setState((){
    total++; // 어디서 addOne을 클릭할 때마다 total 변수에 + 1
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( title : Text(total.toString()),),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder:(c, i){
            return ListTile(
              leading: Image.asset('profile.png'),
              title: Text(name[i]),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
              onPressed: (){
                showDialog(context: context, builder: (context){
                  return DialogUI( addOne : addOne ); // 2. 부모 -> 자식 보내기 (자식 위젯에 그 함수를 전송)
                });
              },
          ),
        );
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.addOne }) : super(key: key);
  final addOne;
  // 3. 등록은 2곳에 (자식은 파라미터로 함수 들어올 수 있다고 등록)
  var inputData = TextEditingController();
  var inputData2 = '';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField( onChanged: (text){ inputData2 = text;  print(inputData2); },), // 입력값이 변하면 코드 실행
            // [] List, {} Map - 한 변수에 여러 개 데이터 저장할 때 사용
            // TextField( controller: inputData,), // 유저가 입력한 데이트럴 변수에 담는다 controller:
            TextButton(child: Text('완료'), onPressed: (){ addOne();} ), //
            // 4. 수정 함수 호출 (완료버튼 누르면 addOne() 동작, total+1 실행)
            TextButton(child: Text('취소'), onPressed: (){ Navigator.pop(context); })
          ],
        )
      )
    );
  }
}
