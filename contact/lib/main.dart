import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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

  getPermission() async {
    var status = await Permission.contacts.status; // 연락처 권한 줬는지 여부
    // Dart 특징 : 오래 걸리는 줄을 제껴두고 다음 줄 실행하려고 함
    // await 붙으면 다음 줄 실행안하고 기다려준다. (async붙어 있어야 안에서 await 사용 가능, 임의 X, Future를 리턴하는 함수에만 붙일 수 있다.)
    if (status.isGranted) {
      print('허락됨'); // 허락하면 실행
      var contacts = await ContactsService.getContacts();
      print(contacts);
      setState((){
        name = contacts;
      });

      // // 성, 이름 , 풀네임 받아오기
      // print(contacts[0].familyName); // 성
      // print(contacts[0].givenName); // 이름
      // print(contacts[0].displayName); // 풀네임

      // // 폰에 연락처 추가하는 방법
      // var newPerson = Contact(); // new Contact(); - new라는 키워드는 class에서 인스턴스를 뽑는 문법인데, (dart) new 생략가능
      // newPerson.givenName = 'Minsu';
      // newPerson.familyName = 'Kim';
      // ContactsService.addContact(newPerson); // 휴대폰 연락처에 newPerson 정보가 들어간다.

    } else if (status.isDenied) {
      print('거절됨'); // 허락안하면/미선택이면 실행
      Permission.contacts.request(); // 허락해달라고 팝업띄우는 코드
      openAppSettings(); // 앱설정화면 켜줌 - 거절당하면 유저가 앱설정 들어가서 직접 권한을 켜야함
    }
  } // 패키지 사용법일뿐

  // @override // 처음 로드될 때 이 코드를 실행해달라
  // void initState() { // initState 안에 적은 코드는 위젯 로드될 때 한번 실행된다.
  //   super.initState();
  //   getPermission(); // 앱 정책상 deny 2번이상 하면 다시 팝업 안뜨기 때문에 allow 잘 누르기
  // }
  // // 처음 로드되자마자 권한요구하는 것보다
  // // 연락처가 본격적으로 필요할 때 실행해주는 것이 좋은 것 같다.

  // Dart는 타입을 엄격하게 지켜야 잘 동작하는 언어
  // 초기 값이 있으면 타입이 알아서 생기기 때문에,
  // 타입을 모두 지정할 필요는 없다.
  var total = 3;
  // int total = 3;
  var name = []; // List<dynamics> 리스트인데 모든 타입 가능
  // List<Contact> name = []; // 변수만들때 미리 타입을 강제 지정할 수도 있음
  var like = [0, 0, 0];
  // List<int> like = [0, 0, 0];

  addName(a){
    setState((){
      name.add(a);
    }); // List에 자료추가하는 방법
  }

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
        appBar: AppBar( title : Text(total.toString()), actions: [
          IconButton(onPressed: (){ getPermission(); }, icon: Icon(Icons.contacts))
        ]),
        body: ListView.builder(
          // itemCount: 3,
          itemCount: name.length, // itemCount: 3이 아닌 동적으로 변경, name 자료길이 만큼 반복되도록 수정.
          itemBuilder:(c, i){
            return ListTile(
              leading: Image.asset('assets/profile.png', width: 100,),
              title: Text(name[i].givenName ?? '이름이없는놈'),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
              onPressed: (){
                showDialog(context: context, builder: (context){
                  return DialogUI( addOne : addOne, addName: addName ); // 2. 부모 -> 자식 보내기 (자식 위젯에 그 함수를 전송)
                });
              },
          ),
        );
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.addOne, this.addName}) : super(key: key);
  final addOne;
  final addName;

  // 3. 등록은 2곳에 (자식은 파라미터로 함수 들어올 수 있다고 등록)
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        width: 300,
        height: 300,
        child: Column(
          children: [
            // TextField( onChanged: (text){ inputData2 = text;  print(inputData2); },), // 입력값이 변하면 코드 실행
            // [] List, {} Map - 한 변수에 여러 개 데이터 저장할 때 사용
            TextField( controller: inputData,), // 유저가 입력한 데이트럴 변수에 담는다 controller:
            TextButton(child: Text('완료'), onPressed: (){
              addOne();
              addName(inputData.text);
            } ),
            // 4. 수정 함수 호출 (완료버튼 누르면 addOne() 동작, total+1 실행)
            TextButton(
                child: Text('취소'),
                onPressed: (){ Navigator.pop(context); })
          ],
        )
      )
    );
  }
}

// build 전 체크 사항
// 1. 변수, 함수에 타입 지정을 잘 했는가
// 2. null check - if문X => 삼항연산자나 ??를 쓴다.
// null이 등장할 것 같은 곳은 한번씩 체크한다.

// C:\"Program Files"\Android\"Android Studio"\jre\bin\keytool -genkey -v -keystore C:\Users\JYK\flutter_keys\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload