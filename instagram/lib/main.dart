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
} // 여기까지 5줄 무시

class _MyAppState extends State<MyApp> {
  var tab = 1;
  var list = [1, 2, 3];
  var map = {'name': 'john', 'age': 20};
  // map['name']  // john이 나온다.
  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json')); // 오래 걸리는 함수(전문용어로 Future)
    var result2 = jsonDecode(result.body); // JSON->[],{} 변환해서 쓴다. (jsonDecode)
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
      // body: [Text('홈페이지'),Text('샵페이지')][1],
      body: [Home(), Text('샵페이지')][tab],
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
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 3, itemBuilder: (c, i){ // ListView.builder() 자동으로 스크롤
      return Container(
        constraints: BoxConstraints(maxWidth: 600), // constraints 최대 폭을 줄 수 있다
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network('https://codingapple1.github.io/kona.jpg'),
                // Image.network('웹이미지주소') 웹에 올려진 이미지
                Text('좋아요 100'),
                Text('글쓴이'),
                Text('내용'),
              ],
            ),
      );
        });
  }
}
