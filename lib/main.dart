import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/shared/theme/app_theme.dart';
import 'package:push_app/shared/router/app_router.dart';
import 'package:push_app/notifier/application/bloc/notification/notification_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationBloc.initializeFirebase();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => NotificationBloc(),
      )
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
