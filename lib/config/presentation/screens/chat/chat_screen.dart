import 'package:flutter/material.dart';
import 'package:yes_no_app/config/domain/entities/message.dart';
import 'package:yes_no_app/config/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/config/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/config/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/config/presentation/widgets/shared/message_field_box.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(6.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://gravatar.com/avatar/37c193c7139ad71ed85b77cbb8ff546a?s=400&d=robohash&r=x'),
          ),
        ),
        title: const Text('Don Robot'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];
                return (message.fromWho == FromWho.hers)
                    ? HerMessageBubble(
                        message: message,
                      )
                    : MyMessageBubble(message: message);
              },
            )),
            //caja de mensajes
            const SizedBox(height: 5),
            MessageFieldBox(
              onValue: (value) => chatProvider.sendMessage(value),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
