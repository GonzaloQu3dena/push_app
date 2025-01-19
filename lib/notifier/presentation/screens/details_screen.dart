import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/notifier/application/bloc/notification/notification_bloc.dart';
import 'package:push_app/notifier/domain/entities/push_message.dart';

/// ### Details Screen
/// This screen shows the details of a push notification. It receives the push message id as a parameter.
/// 
/// #### Properties
/// - [pushMessageId]: The id of the push message to show.
/// 
/// #### Author
/// Gonzalo Quedena
class DetailsScreen extends StatelessWidget {
  final String pushMessageId;

  const DetailsScreen({
    super.key,
    required this.pushMessageId,
  });

  @override
  Widget build(BuildContext context) {
    final PushMessage? message =
        context.read<NotificationBloc>().getMessageById(pushMessageId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Details'),
      ),
      body: (message != null)
          ? _DetailsView(message: message)
          : const Center(
              child: Text('There is no notification'),
            ),
    );
  }
}

class _DetailsView extends StatelessWidget {
  final PushMessage message;

  const _DetailsView({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          if (message.imageUrl != null) Image.network(message.imageUrl!),
          const SizedBox(height: 30),
          Text(
            message.title,
            style: textStyles.titleMedium,
          ),
          Text(message.body),
          const Divider(),
          Text(message.data.toString()),
        ],
      ),
    );
  }
}
