import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CahatPage extends StatefulWidget {
  const CahatPage({super.key});
  static String id = 'chat_page';

  @override
  State<CahatPage> createState() => _CahatPageState();
}

class _CahatPageState extends State<CahatPage> {
  final TextEditingController messageController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  List<Message> mes = [];
  @override
  Widget build(BuildContext context) {
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
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  mes = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: scrollController,
                  reverse: true,
                  itemCount: mes.length,
                  itemBuilder: (context, index) {
                    return mes[index].id ==
                        ModalRoute.of(context)!.settings.arguments.toString()
                        ? ChatBuble(message: mes[index])
                        : ChatBubleForFrend(message: mes[index]);
                  }
                  ,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: messageController,
              onSubmitted: (value) {
                BlocProvider.of<ChatCubit>(context).sendMessage(
                  message: value,
                  email: ModalRoute.of(context)!.settings.arguments.toString(),
                );
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
                    BlocProvider.of<ChatCubit>(context).sendMessage(
                      message: messageController.text,
                      email: ModalRoute.of(
                        context,
                      )!.settings.arguments.toString(),
                    );
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
  }
}
