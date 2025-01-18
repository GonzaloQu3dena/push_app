part of 'notification_bloc.dart';

/// ### Notification Event
/// This class is used to define the events that will be used in the [NotificationBloc].
/// 
/// #### Author 
/// Gonzalo Quedena
abstract class NotificationEvent {
  const NotificationEvent();
}

/// ### Notification Status Changed Event
/// This event is used to notify the [NotificationBloc] that the authorization status has changed.
/// 
/// #### Properties
/// - [status]: The new authorization status.
/// 
/// #### Author
/// Gonzalo Quedena
class NotificationStatusChanged extends NotificationEvent {
  final AuthorizationStatus status;

  NotificationStatusChanged(this.status);
}
