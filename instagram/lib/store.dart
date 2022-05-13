import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Store1 extends ChangeNotifier {  // store는 창고  // 허락받든가 메뉴얼이 필요함
  var follower = 0;
  var friend = false;  // 현재 친구인지 아닌지
  var profileImage = [];  // Profile 페이지 방문시 get 요청해서 데이터 가져오고 그걸 state 안에 넣기

  getProfileData() async {  // Profile 페이지 방문 시 이거 실행하면 된다.
    var profileResult = await http.get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var profileResult2 = jsonDecode(profileResult.body);
    profileImage = profileResult2;
    notifyListeners();
  }

  addFollower() {  // 친구여부 == false면 +1 / 친구여부 == true면 -1
    if (friend == false) {
      follower++;
      friend = true;
    } else {
      follower--;
      friend = false;
    }
    notifyListeners();  // 재렌더링 하라.
  }
}

class Store2 extends ChangeNotifier {  // store는 여러개 만들어도 상관없다.
  var name = 'john kim';
}

// Provider 사용법
// 1. store 만들기
// 2. store 쓸 위젯들 등록

// Provider 사용법 (Profile에서 MyApp의 state 쓰려면)
// 1. state 보관함 (store) 만들기
// 2. store 원하는 위젯 등록하기 - 이 state 쓰고 싶은 위젯들을 전부 ChangeNotifieProvider()로 감싸야 한다.
//    모든 위젯들이 사용할거면 MaterialApp() 을 감싸면 된다.
// 3. store에 있던 state를 사용하고 싶으면 context.watch<store명>() 원하는 것 점찍어서 쓰면 된다. Text(context.watch<Store1>().name)

