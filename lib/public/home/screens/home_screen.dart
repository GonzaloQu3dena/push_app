import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/notifier/application/bloc/notification/notification_bloc.dart';

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
        title: context.select(
          (NotificationBloc bloc) => Text('${bloc.state.status}') 
        ),
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
    return ListView.builder(
      itemCount: 0,
      itemBuilder: (BuildContext context, int index) {
        return const ListTile();
      },
    );
  }
}
