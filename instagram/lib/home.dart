import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter/cupertino.dart';

// lib
import 'profile.dart';

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