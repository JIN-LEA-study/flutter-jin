import 'package:flutter/material.dart';

// firebase
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;  // firestore안에 유용한 함수들이 들어있다. 데이터 꺼내는 함수도.

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {

  getShopData() async {

    // 데이터 업데이트
    // await firestore.collection('product').doc().update({'name' : 'ddd'});  // ID 잘 입력

    // 데이터 삭제
    // await firestore.collection('product').doc().delete();

    // 선별적 데이터 불러오기
    // await firestore.collection('product').where().get();
    // price 항목이 7000이하인 것만 가져와주세요
    // 날짜 순으로 데이터 20개만 가져와주세요

    // 데이터 저장
    await firestore.collection('product').add({'name' : '내복', 'price' : 6000});
    // 저장 실패 체크하려면, 아래와 같은 방식으로 try, catch 문법 쓰면 된다.

    // 2. 에러 처리
    // try {
    //   var shopResult = await firestore.collection('product').get();
    //     for (var doc in shopResult.docs) {
    //       print(doc['name']);
    //     }
    //   print('성공');
    // } catch (e) {
    //   print('에러');
    // }

    // 1. 에러 처리
    // var shopResult = await firestore.collection('product').get();
    // if (shopResult.docs.isNotEmpty) {
    //   for (var doc in shopResult.docs) {
    //     print(doc['name']);
    //   }
    // }
    // var shopResult = await firestore.collection('product').doc('4nmTIG2Hv61z7xZL8KsG').get();  // document id
    // print(shopResult['price']);  // collection의 모든 document를 가져오면 리스트안에 담아준다.
  }

  @override
  void initState() {  // 이 안에서는 await을 쓸 수 없어서 밖에서 함수를 만든다.
    super.initState();
    getShopData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('샵페이지임!!'),
    );
  }
}
