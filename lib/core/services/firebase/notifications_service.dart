import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geeta/core/constants/enum.dart';
import 'package:geeta/core/routes/app_routes.dart';
import 'package:get/get.dart';

@pragma("vm:entry-point")
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // do anything
}

class NotificationsService extends GetxService {
  NotificationsService();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();


  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
        "geeta_products",
        "products Notifications",
        description: "Notifications about payment",
        importance: Importance.high,
      );

      static const AndroidNotificationChannel _accountChannel =
      AndroidNotificationChannel(
    'x_fashion_account',
    'Account Notifications',
    description: 'Notifications about your account',
    importance: Importance.high,
  );

  
  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _requestPermissions();
    await _initializeLocalNotifications();
    await _configureForegroundMessages();
    await _configureNotificationClickHandling();
   
  }

  Future<void> _requestPermissions() async {
    await _messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
      provisional: false,
    );
  }

  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (details) {
        _handleLocalNotificationClick(details.payload);
      },
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidChannel);
  }

  Future<void> _configureForegroundMessages() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
    FirebaseMessaging.onMessage.listen((message) async {
      await _showForegroundNotification(message);
    });
  }

  Future<void> _configureNotificationClickHandling() async {
    FirebaseMessaging.onMessageOpenedApp.listen(_handleRemoteMessageClick);
    final _initialMessage = await _messaging.getInitialMessage();
    if (_initialMessage != null) {
      _handleRemoteMessageClick(_initialMessage);
    }
  }

  

  void _handleRemoteMessageClick(RemoteMessage message) {
    _navigateFromData(message.data);
  }
/*
  Future<void> _showForegroundNotification(RemoteMessage message) async {
    final payload = jsonEncode(message.data);
    await _localNotificationsPlugin.show(
      id: message.hashCode,
      title: message.notification?.title ?? "",
      body: message.notification?.body ?? "",
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          importance: _androidChannel.importance,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: payload,
    );
  }*/

Future<void> showLocal({
    required String title,
    required String body,
    Map<String, dynamic> data = const {},
    AppNotificationChannel channel = AppNotificationChannel.orders,
  }) async {
    try {
      final ch = _channelOf(channel);
      await _localNotificationsPlugin.show(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: title,
        body: body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            ch.id,
            ch.name,
            channelDescription: ch.description,
            importance: ch.importance,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: jsonEncode(data),
      );
    } catch (e) {
      debugPrint('showLocal error: $e');
    }
  }

Future<void> _showForegroundNotification(RemoteMessage message) => showLocal(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        data: message.data,
      );
  void _handleLocalNotificationClick(String? payload) {
    if (payload == null || payload.isEmpty) return;
    try {
      final decoded = jsonDecode(payload);
      if (decoded is Map<String, dynamic>) {
        _navigateFromData(decoded);
      } else if (decoded is Map) {
        _navigateFromData(decoded.cast<String, dynamic>());
      }
    } catch (error) {
      debugPrint("error in _handleLocalNotificationClick : $error");
    }
  }

  AndroidNotificationChannel _channelOf(AppNotificationChannel c) =>
      c == AppNotificationChannel.orders ? _androidChannel : _accountChannel;

  void _navigateFromData(Map<String, dynamic> data) {
  switch (data['type']) {
    case 'order':
      Get.toNamed(AppRoutes.home); // orders
    case 'account':
      break;
    default:
      debugPrint('unknown notification type: ${data['type']}');
  }
}

   Future<String?> getToken() => _messaging.getToken();

  /// Stream لتجديد التوكن، بيشترك فيها الـ Repository
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  /// عند تسجيل الخروج: نبطل التوكن القديم عشان ما توصل إشعارات
  Future<void> deleteToken() => _messaging.deleteToken();
}

/*
instance : flutee
* instance of AndroidNotificatinChannel / static const
* inside initialize :
*
* */
