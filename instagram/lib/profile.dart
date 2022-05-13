import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// lib
import 'store.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.watch<Store2>().name),),
        body: CustomScrollView(  // 각각이 아닌 전체 스크롤바 생성해주는 CustomScrollView() children이 아닌 slivers로 작성해야 한다.
          slivers: [  // slivers 안에 있는 것들을 다 합쳐서 스크롤바를 만들어 줌
            SliverToBoxAdapter(child: ProfileHeader()),
            SliverGrid(delegate: SliverChildBuilderDelegate(
                  (c, i) => Image.network(context.watch<Store1>().profileImage[i]),
              childCount: context.watch<Store1>().profileImage.length,
            ),  // 격자 몇개 만들 것
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2 )),
            // SliverList(delegate: delegate),
            // SliverAppBar(),
          ],
          // slivers 안에는 평소에 쓰던 위젯을 못 넣는다.
          // 격자 넣고 싶으면 SliverGrid()
          // ListView넣고 싶으면 SliverList()
          // Container 넣고 싶으면 SliverToBoxAdapter()
          // 예쁜 헤더는 SliverAppBar()

          // GridView.builder(  // 격자 만들 땐 GridView.builder()
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2 ),
          //   itemBuilder: (c, i) {
          //     return Container(color : Colors.grey);
          //   },
          //   itemCount: 3,
          // ),
        )
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(  // 이미지를 동그랗게 넣고 싶으면 CircleAvatar()
          radius: 30,
          backgroundColor: Colors.grey,
          // backgroundImage: ,
        ),
        Text('팔로워 ${context.watch<Store1>().follower}명'),
        ElevatedButton(onPressed: () {  // 버튼을 누르면 위에 있는 state 수정 방법을 꺼내 쓰고 싶다.
          context.read<Store1>().addFollower();  // 함수 이름 갖다 쓴다.
        }, child: Text('팔로우')),
        ElevatedButton(onPressed: () {
          context.read<Store1>().getProfileData();
        }, child: Text('사진 가져오기')),
      ],
    );
  }
}
