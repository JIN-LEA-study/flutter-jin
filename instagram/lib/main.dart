import 'package:flutter/material.dart';
import 'style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 1;
  var data = [];  // 데이터 들어오는데 몇초 걸린다.

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json')); // 오래 걸리는 함수(전문용어로 Future, Future를 뱉는 함수)
    // 여러가지 예외처리 필요
    // - 서버가 다운되었거나
    // - 요청 경로가 이상하거나
    // if (result.statusCode == 200) {  // 성공시 보통 200이 남는다, 실패시 4XX, 5XX
    //
    // } else{  // 실패시
    //
    // }

    // Dio 패키지 설치하면 GET요청이 좀 더 짧아진다.

    var result2 = jsonDecode(result.body); // JSON->[],{} 변환해서 쓴다. (jsonDecode)
    setState(() {
      data = result2;
    });
    print(result2[0]['likes']);
  }

  // 로드 되면 바로 GET 요청
  @override
  void initState() {
    super.initState();
    getData();
  }

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
      // future: 에 입력한 Future가 완료되면, builder: 안의 위젯을 보여준다.
      // FutureBuilder위젯: Future 변수가 실제 데이터로 변할 때 내부 코드 1회 실행해주는 위젯
      // - 데이터가 자주 추가되면 쓰기 불편하다.
      // - 데이터가 나중에 추가 안되는 경우 유용
      body: [FutureBuilder(
          future: http.get('어쩌구'),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              return Text('post에 데이터 있으면 보여줄 위젯')
            }
            return Text('post에 데이터 없으면 보여줄 위젯')
          },
      ), Text('샵페이지')][tab],
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

class Home extends StatelessWidget {
  const Home({Key? key, this.data}) : super(key: key);
  final data; // final, 부모가 보낸건 보통 수정하지 않는다.

  @override
  Widget build(BuildContext context) {
    // print(data); // print()는 함수 안에서 쓰면 된다.

    if (data.isNotEmpty){  // data에 뭐 들어있으면 보여달라
      return ListView.builder(itemCount: 3, itemBuilder: (c, i){ // i는 1씩 증가하는 정수
        return Container(
          constraints: BoxConstraints(maxWidth: 600), // constraints 최대 폭을 줄 수 있다
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(data[i]['image']),
              // Image.network('웹이미지주소') 웹에 올려진 이미지
              Text('좋아요 100'),
              Text('글쓴이'),
              // Text(data[0]['content']),
              Text(data[i]['content']),
              // 데이터 들어오기도 전에 data[i]['content']하면 에러난다.
            ],
          ),
        );
      });
    } else {
      return Text('로딩중임'); // CircularProgressIndicator()
   }
  }
}
