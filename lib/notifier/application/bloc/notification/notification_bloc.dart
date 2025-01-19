import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:push_app/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_app/notifier/domain/entities/push_message.dart';

part 'notification_event.dart';
part 'notification_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

/// ### Notification Bloc
/// This class is used to manage the notification state of the application.
/// 
/// #### Properties
/// - [messaging]: The Firebase Messaging instance.
/// 
/// #### Methods
/// - [requestPermission]: Requests the permission to send notifications.
/// - [initialFirebase]: Initializes Firebase. It is a static method that should be called before creating an instance of this class.
/// 
/// #### Author
/// Gonzalo Quedena
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationBloc() : super(NotificationState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_onPushMessageReceived);

    _initialStatusCheck();
    _onForegroundMessage();
  }

  Future<void> requestPermission() async {
    final NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // This method is used to check the initial status of the notifications.
  Future<void> _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  // This method is used to get the FCM token.
  Future<void> _getFcmToken() async {
    final settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    print('FCM Token: $token');
  }

  // This method is used to handle the notification status change.
  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationState> emit) {
    emit(
      state.copyWith(status: event.status),
    );
    _getFcmToken();
  }

  // This method is used to handle the received notification.
  void _onPushMessageReceived(
      NotificationReceived event, Emitter<NotificationState> emit) {
    emit(
      state.copyWith(
        notifications: [event.pushMessage, ...state.notifications],
      ),
    );
  }

  // This method is used to handle the received notification when the app is in the foreground.
  void _handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

    final notification = PushMessage(
      messageId:
          message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
          ? message.notification!.android?.imageUrl
          : message.notification!.apple?.imageUrl,
    );

    //print(notification.toString());

    add(NotificationReceived(notification));
  }

  // This method is used to listen to the messages when the app is in the foreground.
  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }
}
