import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/notifier/application/bloc/notification/notification_bloc.dart';
import 'package:push_app/notifier/domain/entities/push_message.dart';

/// ### Home Screen
/// This is the main screen of the application. It will display the list of licenses.
///
/// #### Author
/// Gonzalo Quedena
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context
            .select((NotificationBloc bloc) => Text('${bloc.state.status}')),
        actions: [
          IconButton(
            onPressed: () {
              context.read<NotificationBloc>().requestPermission();
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: _HomeView(),
    );
  }
}

/// ### Home View
/// This is the view of the home screen. It will display the list of licenses.
///
/// #### Author
/// Gonzalo Quedena
class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<NotificationBloc>().state.notifications;

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        final notification = notifications[index];  
        return _NotificationTile(notification: notification);
      },
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final PushMessage notification;

  const _NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(notification.title),
      subtitle: Text(notification.body),
      leading: notification.imageUrl != null
          ? Image.network(notification.imageUrl!)
          : null,
    );
  }
}