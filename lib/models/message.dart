class Message {
  final String message;
  final String id;

  Message({required this.message, this.id = ''});
  factory Message.fromJson(Map<String, dynamic> jsonData) {
    return Message
    (message: jsonData['message'] ??
     '', id: jsonData['id'] ?? '');
  }
}
