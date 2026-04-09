import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CahatPage extends StatefulWidget {
   
 const CahatPage({super.key, });
  static String id = 'chat_page';

  @override
  State<CahatPage> createState() => _CahatPageState();
}

class _CahatPageState extends State<CahatPage> {
  final CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );

  final TextEditingController messageController = TextEditingController();

 final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
  String email=  ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(
        'timestamp',
      descending: true,
      ).snapshots(),
      builder: (context, snapshot) {
       
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (var doc in snapshot.data!.docs) {
            messagesList.add(Message.fromJson(doc.data() as Map<String, dynamic>));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/scholar.png', height: 50),

                  const Text('Chat', style: TextStyle(color: Colors.white)),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      controller: scrollController,
                     reverse: true,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id==email? ChatBuble(
                        message: messagesList[index],
                      ):ChatBubleForFrend(message: messagesList[index],);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: messageController,
                    onSubmitted: (value) {
                      messages.add({
                        'message': value,
                        'timestamp': FieldValue.serverTimestamp(),
                        'id': email
                      });
                      messageController.clear();
                    Future.delayed(const Duration(milliseconds: 100), () {
                        scrollController.animateTo(
                        0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Type your message',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          messages.add({
                            'message': messageController.text,
                            'timestamp': FieldValue.serverTimestamp(),
                            'id': email
                          });
                          messageController.clear();
                          Future.delayed(const Duration(milliseconds: 100), () {
                            scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      
    );
  }
}
