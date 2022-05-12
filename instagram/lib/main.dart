import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  var userImage;  // 선택한 이미지를 위젯에 보여주기
  var userContent;

  addMyData() {  // 발행 버튼 누르면 이 코드가 실행되어야 한다.  // MyApp 위젯에 있음
    var myData = {
      'id': data.length,  // 게시글의 unique한 id
      'image': userImage,
      'likes': 5,
      'date': 'July 25',
      'content': userContent,
      'liked': false,
      'user': 'John Kim'
    };
    setState(() {
      // data.add(myData)  // add는 맨뒤에 추가가 된다.
      data.insert(0, myData);  // 몇번째 항목에 추가할 지 결정할 수 있다.  // 여기선(0) 맨 앞에 추가 된다.
    });
  }

  setUserContent(a){
    setState(() {
      userContent = a;
    });
  }
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
              onPressed: () async {
                var picker = ImagePicker();
                var image = await picker.pickImage(source: ImageSource.gallery);  // 사진 선택화면 띄우는 법 (패키지 사용법일 뿐)
                // var image = await picker.pickImage(source: ImageSource.camera);  // 카메라
                // var image = await picker.pickMultiImage(source: ImageSource.gallery);  // 여러 이미지
                // var video = await picker.pickVideo(source: ImageSource.gallery);  // 비디오

                // userImage = File(image.path);  // 이대로 썼을 때 에러가 나는 이유는 image가 null일 수도 있기때 문에 미리 걱정해주는 것
                if (image != null) {
                  setState(() {
                    userImage = File(image.path);
                  });
                }
                // Image.file(userImage);  // 파일 경로로 이미지 띄우는 법

                Navigator.push(context,
                  MaterialPageRoute(builder: (c) => Upload(
                      userImage : userImage, setUserContent: setUserContent,
                      addMyData : addMyData,
                  ))  // 부모에서 전송
                );
              },
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
                  // 1 == 1 ? '이거':'저거',  // 참일 때 이거, 거짓일 때 저거
                  // 삼항연산자 문법 if문의 대용품
                  // 조건식 ? 조건식이 참이면 실행할 코드 : 조건식이 거짓이면 실행할 코드
                  // runtimeType : 왼쪽에 있는 타입을 출력하라.
                  widget.data[i]['image'].runtimeType == String
                      ? Image.network(widget.data[i]['image'])
                      : Image.file(widget.data[i]['image']),
                  // Image.network()에는 http부터 시작하는 이미지만 가능
                  // 유저가 선택한 이미지는 _File타입
                  // (에러) _File타입인데 왜 String 타입 자리에 집어넣었냐
                  // 만약 이미지가 String타입이면 Image.network()
                  // 아니면 Image.file()
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

class Upload extends StatelessWidget {
  const Upload({Key? key, this.userImage, this.setUserContent, this.addMyData}) : super(key: key);  // 등록
  final userImage;
  final setUserContent;
  final addMyData;

  @override
  Widget build(BuildContext context) {  // 아래 context는 이 context 부모 데이터들이 담겨있다. 그 중에 MaterialApp도 있을 것이고

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar( actions: [
          IconButton(onPressed: () {
            addMyData();
          }, icon: Icon(Icons.send))
        ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(userImage),  // 부모에 있던 state를 자식이 쓰려면 보내줘야 한다.
            Text('이미지업로드화면'),
            TextField(onChanged: (text) {  // 유저가 입력한 글을 뜻한다.
              setUserContent(text);  // TextField()에 입력값이 변할 때마다 onChanged 안의 함수가 실행된다.
            },),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);  // 이 context는 MaterialApp의 정보가 들어있으면 된다.
                },
                icon: Icon(Icons.close),
            ),
          ],
        )
    );
  }
}