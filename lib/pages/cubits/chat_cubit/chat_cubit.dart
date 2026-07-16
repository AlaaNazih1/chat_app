import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );
  void sendMessage({required String message, required String email}) {
     try {
  messages.add({
   'message': message,
   'timestamp': FieldValue.serverTimestamp(),
   'id': email,
      });
} on Exception catch (e) {
  
}
    
  }
  void getMessages() {
    messages.orderBy(
      'timestamp',
      descending: true,
    ).snapshots().listen((event) {
      emit(ChatSuccess());
    });
  }
}
