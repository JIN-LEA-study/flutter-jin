import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final notifications = FlutterLocalNotificationsPlugin();

// 앱로드시 1회 실행 필요
// 1. 앱로드시 실행할 기본 설정
initNotification() async {

  // android/app/src/main/res/drawable 폴더에 알림에 띄울 아이콘용 이미지를 추가
  // 안드로이드용 아이콘 파일 이름
  var androidSetting = AndroidInitializationSettings('app_icon');

  // ios에서 알림띄우기 전 허락 받는 코드
  // ios에서 앱 로드시 유저에게 권한 요청하려면
  var iosSetting = IOSInitializationSettings(
    requestAlertPermission: true,  // 알람
    requestBadgePermission: true,  // 뱃지
    requestSoundPermission: true,  // 소리
  );

  var initializationSettings = InitializationSettings(
      android: androidSetting,
      iOS: iosSetting
  );
  await notifications.initialize(
    initializationSettings,
    // 알림 누를 때 함수 실행하고 싶으면
    // onSelectNotification: 함수명 추가
  );
}

// 2. 이 함수 원하는 곳에서 실행하면 알림 뜸
showNotification() async {

  var androidDetails = AndroidNotificationDetails(
    '유니크한 알림 채널 ID',  // 알림채널 ID 기입란 ('sales_notification_1' 이런거)
    '알림종류 설명',  //  알림 채널 설명 기입란 ('할인 알림' 이런거)
    priority: Priority.high,  // 중요도에 따라서 소리여부 팝업여부 결정 가능
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),  // 앱 아이콘 색상 지정
  );

  var iosDetails = IOSNotificationDetails(
    presentAlert: true,  // 보여줄지 여부
    presentBadge: true,  // 뱃지 표현 여부
    presentSound: true,  // 소리 낼지 여부
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.show(
      1,  // 개별 알림 ID 숫자
      '제목1',
      '내용1',
      NotificationDetails(android: androidDetails, iOS: iosDetails)
  );
}