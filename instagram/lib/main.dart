import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';  // convert는 유용한 함수 몇개 들어있는 기본 패키지
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

// lib
import 'home.dart';
import 'store.dart';
import 'upload.dart';
import 'notification.dart';

void main() {
  runApp(
      MultiProvider(  // store 여러개면 MultiProvider로 등록해야 한다.
          providers: [
            ChangeNotifierProvider(create: (c) => Store1()),
            ChangeNotifierProvider(create: (c) => Store2()),
          ],

          child: MaterialApp(
              theme: style.theme,
              home: MyApp()
          )
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
    // print(jsonDecode(result3)['age']);  // JSON -> Map 변환은 jsonDecode(map자료)  // jsonDecode()안엔 문자 넣기
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
    initNotification();
    saveData();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(child: Text('+'), onPressed: () {
          showNotification();
          },
        ),
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
