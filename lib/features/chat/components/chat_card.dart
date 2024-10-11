import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:limcad/features/chat/models/chat.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:nb_utils/nb_utils.dart';


class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.chat,
    required this.press,
    required this.messages,
  });

  final Room chat;
  final VoidCallback press;
  final Stream<List<Message>> messages;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: messages,
      initialData: const [],
      builder: (context, snapshot) {
        return InkWell(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Profile Image (Circle Avatar)
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(chat.imageUrl ?? ""),
                ),
                const SizedBox(width: 16), // Space between avatar and text
                // Message Preview
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Chat name
                      Text(
                        chat.name ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Last message preview
                      Opacity(
                        opacity: 0.64,
                        child: Text(
                          _getLastMessageType(snapshot.data?.first),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                // Timestamp
                Opacity(
                  opacity: 0.64,
                  child: Text(
                    _formatTimestamp(chat.lastMessages?.last?.createdAt, context),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                // Unread Message Count Indicator
                // if (chat.unreadMessagesCount > 0)
                //   Container(
                //     height: 20,
                //     width: 20,
                //     decoration: const BoxDecoration(
                //       color: Colors.blue,
                //       shape: BoxShape.circle,
                //     ),
                //     child: Center(
                //       child: Text(
                //         chat.unreadMessagesCount.toString(),
                //         style: const TextStyle(
                //           color: Colors.white,
                //           fontSize: 12,
                //         ),
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getLastMessageType(Message? message) {
    if (message == null) return "";

    switch (message.type) {
      case MessageType.text:
        return (message as TextMessage).text;
      case MessageType.image:
        return "Image";
      case MessageType.file:
        return "File";
      case MessageType.video:
        return "Video";
      default:
        return "Unsupported message";
    }
  }

  String _formatTimestamp(int? timestamp, BuildContext context) {
    if (timestamp == null) return "";

    // Convert the int timestamp (milliseconds since epoch) to DateTime
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final time = TimeOfDay.fromDateTime(dateTime);

    return time.format(context); // Use context here
  }
}
