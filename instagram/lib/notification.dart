import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final notifications = FlutterLocalNotificationsPlugin();


// 1. 앱로드시 실행할 기본 설정
initNotification() async {

  // 안드로이드용 아이콘 파일 이름
  var androidSetting = AndroidInitializationSettings('app_icon');

  // ios에서 앱 로드시 유저에게 권한 요청하려면
  var iosSetting = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
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