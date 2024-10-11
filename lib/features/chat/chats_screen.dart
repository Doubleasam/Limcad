import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:limcad/features/chat/components/body.dart';
import 'package:limcad/features/chat/components/chat_card.dart';
import 'package:limcad/features/chat/message_screen.dart';
import 'package:limcad/features/chat/util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:limcad/resources/widgets/default_scafold.dart';


class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  bool _error = false;
  bool _initialized = false;
  User? _user;

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  void initializeFlutterFire() async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          _user = user;
        });
      });
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  int _selectedIndex = 1;


  Widget _buildAvatar(types.Room room) {
    var color = Colors.transparent;

    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
              (u) => u.id != _user!.uid,
        );

        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found.
      }
    }

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
        radius: 20,
        child: !hasImage
            ? Text(
          name.isEmpty ? '' : name[0].toUpperCase(),
          style: const TextStyle(color: Colors.white),
        )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold2(
      showAppBar: true,
      includeAppBarBackButton: true,
      title: "Chat",
      backgroundColor: CustomColors.backgroundColor,
      body:
      StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: const Text('No chats'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final room =  snapshot.data![index];
              final messages = FirebaseChatCore.instance.messages(room);
              return ChatCard(
                chat: room,
                messages: messages,
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  MessagesScreen(room),
                  ),
                ),
              );
            },
          );
        },
      ),

    );
  }

}