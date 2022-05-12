import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';  // 스크롤 관련 유용한 함수  // 스크롤 다룰때 import 해두고 쓰는게 좋다.

void main() {
  runApp(
      MaterialApp(
          theme: style.theme,
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
  var tab = 0;
  var data = [];

  addData(a) {
    setState(() {
      data.add(a);  // .add()하면 리스트 안에 자료 추가 가능
    });
  }

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));  // 오래 걸리는 함수 (전문용어로 Future, Future를 뱉는 함수)
    if (result.statusCode == 200) {  // 성공시 보통 200이 남는다, 실패시 4XX, 5XX

    } else {  // 실패시

    }
    var result2 = jsonDecode(result.body);  // JSON->[],{} 변환해서 쓴다. (jsonDecode)

    setState(() {
      data = result2;
    });
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
      body: [Home(data: data, addData: addData ), Text('샵페이지')][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap:(i) {
          setState(() {
            tab = i;
          });
        },
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label:'홈'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label:'샵'),
        ]
      ),
    );
  }
}

class Home extends StatefulWidget {  // 스크롤 바 높이 측정하려면, 우선 ListView담은 곳이 StatefulWidget이어야 한다. 전구이용해서 변경한다.
  const Home({Key? key, this.data, this.addData}) : super(key: key);  // 부모가 보낸 state 등록은 첫번째 class에
  final data;
  final addData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {  // 사용은 두번째 class에
  var scroll = ScrollController();  // 위치 측정은 스크롤 움직일 때마다 해야한다.(바닥인지 계속 체크해야)

  getMore() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var result2 = jsonDecode(result.body);
    widget.addData(result2);
  }

  @override
  void initState() {
    super.initState();  // 스크롤바 높이 측정하려면 - 리스너 부착하기
    scroll.addListener(() {  // scroll 변수가 변할 때마다 addlistener로 특정 코드 실행  // 필요없어지면 제거하는 것도 성능상 좋다.
      if (scroll.position.pixels == scroll.position.maxScrollExtent){
        // print('같음');
        getMore();
      }
      // print(scroll.position.maxScrollExtent);  // 스크롤바 최대 내릴 수 있는 높이
      // print(scroll.position.userScrollDirection);  // 스크롤 되는 방향 (ScrollDirection.forward, ScrollDirection.reverse)
   });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.addData);
    if (widget.data.isNotEmpty) {  // 첫 class안에 있던 변수 사용은 widget.변수명
      return ListView.builder(itemCount: widget.data.length, controller: scroll, itemBuilder: (c, i) {  // 유저가 얼마나 스크롤 했는지 정보가 scroll 변수에 저장된다.
            return Container(
              constraints: BoxConstraints(maxWidth: 600),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(widget.data[i]['image']),
                  Text('좋아요 ${widget.data[i]['likes']}'),
                  Text(widget.data[i]['date']),
                  Text(widget.data[i]['content']),
                ],
              ),
            );
          });
    } else {
      return CircularProgressIndicator();
    }
  }
}
