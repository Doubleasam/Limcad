import 'package:flutter/material.dart';
import 'package:limcad/features/chat/components/chat_input_field.dart';
import 'package:limcad/features/chat/components/message.dart';
import 'package:limcad/features/chat/models/chat_message.dart';



class MessageBody extends StatelessWidget {
  const MessageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) =>
                  Message(message: demeChatMessages[index]),
            ),
          ),
        ),
        const ChatInputField(),
      ],
    );
  }
}