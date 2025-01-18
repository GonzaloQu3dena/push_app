part of 'notification_bloc.dart';

/// ### Notification State
/// This class is used to manage the state of the notification bloc.
/// 
/// #### Properties
/// - [status] - Authorization status of the notification.
/// - [notifications] - List of notifications.
/// 
/// #### Methods
/// - [copyWith] - Copy the current state with new values.
/// 
/// #### Author
/// Gonzalo Quedena
class NotificationState extends Equatable {

  final AuthorizationStatus status;
  // TODO: notifications model.
  final List<dynamic> notifications;

  const NotificationState({
    this.status = AuthorizationStatus.notDetermined,
    this.notifications = const [],
  });

  NotificationState copyWith({
    AuthorizationStatus? status,
    List<dynamic>? notifications,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object> get props => [status, notifications];
}
