part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

 class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  List<Message> messages;
  ChatSuccess({this.messages = const []});
}

class ChatError extends ChatState {
  final String message;
  ChatError({required this.message});
}
