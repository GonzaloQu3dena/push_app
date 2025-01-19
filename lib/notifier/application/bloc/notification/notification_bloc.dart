import 'package:equatable/equatable.dart';
import 'package:push_app/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

part 'notification_event.dart';
part 'notification_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore, make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

/// ### Notification Bloc
/// This bloc is responsible for handling the notification events. It uses the Firebase Messaging plugin to request permission for notifications.
///
/// #### Properties
/// - [messaging] - Firebase Messaging instance.
///
/// #### Methods
/// - [requestPermission] - Requests permission for notifications.
/// - [initializeFirebase] - Initializes Firebase.
///
/// #### Author
/// Gonzalo Quedena
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationBloc() : super(NotificationState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);

    _initialStatusCheck();
    _onForegroundMessage();
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
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

  // This method is called when the bloc is created.
  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  // This method is called when the notification status changes.
  void _getFcmToken() async {
    final settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    print('FCM Token: $token');
  }

  // This method is called when the notification status changes.
  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationState> emit) {
    emit(
      state.copyWith(
        status: event.status,
      ),
    );
    _getFcmToken();
  }

  // This method is called when a remote message is received. 
  void _handleRemoteMessage(RemoteMessage message) {
    if (message.notification != null) return;
  }
  
  // This method is called when the app is in the foreground. Foreground is when the app is open.
  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }
}
