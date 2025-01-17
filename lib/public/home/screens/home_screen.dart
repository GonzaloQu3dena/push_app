import 'package:flutter/material.dart';

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
        title: const Text('Licences'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: request notification license.
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
    return Placeholder();
  }
}
