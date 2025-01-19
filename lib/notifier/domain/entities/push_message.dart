/// ### Push Message
/// This class is used to represent a push message.
/// 
/// #### Properties
/// - [messageId] - The unique identifier of the message.
/// - [title] - The title of the message.
/// - [body] - The body of the message.
/// - [sentDate] - The date and time the message was sent.
/// - [data] - The data associated with the message.
/// - [imageUrl] - The URL of the image associated with the message.
/// 
/// #### Author
/// Gonzalo Quedena
class PushMessage {
  final String messageId;
  final String title;
  final String body;
  final DateTime sentDate;
  final Map<String, dynamic>? data;
  final String? imageUrl;

  PushMessage({
    required this.messageId,
    required this.title,
    required this.body,
    required this.sentDate,
    this.data,
    this.imageUrl,
  });

  @override
  String toString() {
    return '''
    PushMessage - 
    id:        $messageId
    title:     $title
    body:      $body
    sentDate:  $sentDate
    data:      $data
    imageUrl:  $imageUrl
    ''';
  }
}
