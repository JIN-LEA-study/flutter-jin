import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';  // convert는 유용한 함수 몇개 들어있는 기본 패키지
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

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

  saveData() async {
    var storage = await SharedPreferences.getInstance();  // 저장 공간 오픈 하는 방법
    // storage.setString('name', 'john');  // (유저가 삭제하지 않는 이상) 반영구적으로 보관 완료
    // storage.remove('name');  // 데이터 삭제
    // var result = storage.getString('name');  // 데이터 꺼내는 함수 getString() getBool() getInt() getDouble() getStringList()
    var map = {'age' : 20};
    storage.setString('map', jsonEncode(map));  // Map저장 함수는 없다. JSON으로 바꿔서 저장해야 한다.
    var result3 = storage.getString('map') ?? '없는데요';  // JSON임(문자임)  // null체크를 해줘야 에러가 뜨지 않는다.
    print(jsonDecode(result3)['age']);  // JSON -> Map 변환은 jsonDecode(map자료)  // jsonDecode()안엔 문자 넣기
    // print(result);
  }

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

  setUserContent(a) {
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
  // 데이터 보존 방법
  // 1. 서버로 보내서 DB에 저장 - 중요한 것
  // 2. 폰 메모리 카드에 저장 (shared preferences 이용) - 덜 중요한 것 (웹브라우저로 치면 localStorage와 똑같은 곳임 )
  // 로드 되면 바로 GET 요청
  @override
  void initState() {
    super.initState();
    saveData();
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
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
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

                  widget.data[i]['image'].runtimeType == String
                      ? Image.network(widget.data[i]['image'])
                      : Image.file(widget.data[i]['image']),

                  GestureDetector(
                    child: Text(widget.data[i]['user']),
                    onTap: () {
                      Navigator.push(context,
                          // MaterialPageRoute(builder: (c) => Text('위젯')));
                          // CupertinoPageRoute(builder: (c) => Profile()));  // Slide  // 페이지 전환 커스텀 애니메이션  // 1. 쉬운 방법
                          PageRouteBuilder(  // 페이지 전환 커스텀 애니메이션  // 2. PageRouteBuilder
                            pageBuilder: (c, a1, a2) => Profile(),  // 기본 파라미터 3개정도 채운다. 쓸데는 없는데, 채워야 한다.
                            transitionsBuilder: (c, a1, a2, child) =>  // transitionsBuilder: () => 애니메이션용 위젯()  // 파라미터 4개를 입력하고 애니메이션을 return
                            SlideTransition(  // Slide Animation
                              position: Tween(
                                begin: Offset(-1.0, 0.0),  // 시작 좌표  // 페이지의 X축 위치 (-1.0, 0.0 => 왼쪽에서 오른쪽으로) (1.0, 0.0 => 오른쪽에서 왼쪽으로)
                                end: Offset(0.0, 0.0),  // 최종 좌표
                              ).animate(a1),
                              child: child,
                            )
                            // 파라미터 설명
                            // 1. c => context (쓸데없음)
                            // 2. a1 => animation object 0에서 1로 증가하는 애니메이션 숫자 (새로운 페이지에 씀)  // 페이지 전환 시작시 0, 페이지 전환 끝나면 1.
                            // 3. a2 => 0에서 1로 증가하는 애니메이션 숫자 (기존에 보이던 페이지에 씀)  // 페이지 전환이 얼마나 되었는지 0~1로 알려준다.
                            // 4. child => 현재 보여주는 위젯을 뜻한다.
                          )
                      );  // slide
                      },
                    // onTap: () { 한 번 누를시 실행할 코드 }
                    // onDoubleTap: () { 더블탭시 실행할 코드 }
                    // onLongPress: () { 길게 누를시 실행할 코드 }
                    // onScaleStart: () { 줌인시 실행할 코드 }
                    // onHorizontalDragStart: () { 수평으로 드래그시 실행할 코드 }
                  ),

                  // Text(widget.data[i]['user']),  // 이거 누르면 Navigator.push() 되도록 but Text 위젯 안에는 onPressed가 안된다.
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

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('프로필페이지'),
    );
  }
}
