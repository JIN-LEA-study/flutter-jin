import 'package:flutter/material.dart';

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

