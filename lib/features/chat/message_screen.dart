import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/src/room.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:limcad/features/chat/components/chat_input_field.dart';
import 'package:limcad/features/chat/components/message_body.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:limcad/resources/storage/base_preference.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/context.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


class MessagesScreen extends StatefulWidget {
  final types.Room room;
  const MessagesScreen(this.room, {super.key});


  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  bool _isAttachmentUploading = false;
  String receiverId = "";

  @override
  void initState() {
    getPref();
    super.initState();
  }

    getPref() async {
    BasePreference _preference = await BasePreference.getInstance();
        setState(() {
          receiverId = _preference.getProfileDetails()?.id.toString() ?? "";
        });
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child:  Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ).paddingSymmetric(horizontal: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                    _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ).paddingSymmetric(horizontal: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ).paddingSymmetric(horizontal: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      _setAttachmentUploading(true);
      final name = result.files.single.name;
      final filePath = result.files.single.path!;
      final file = File(filePath);

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialFile(
          mimeType: lookupMimeType(filePath),
          name: name,
          size: result.files.single.size,
          uri: uri,
        );

        FirebaseChatCore.instance.sendMessage(message, widget.room.id);
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.room.id,
        );
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold2(
        showAppBar: true,
        includeAppBarBackButton: true,
        title: "${widget.room.users.firstWhere((element) => element.id != receiverId).firstName ?? ""} ${widget.room.users.firstWhere((element) => element.id != receiverId).lastName ?? ""}",
        backgroundColor: CustomColors.backgroundColor,
      body:
      StreamBuilder<types.Room>(
        initialData: widget.room,
        stream: FirebaseChatCore.instance.room(widget.room.id),
        builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
          initialData: const [],
          stream: FirebaseChatCore.instance.messages(snapshot.data!),
          builder: (context, snapshot) => Chat(
            isAttachmentUploading: _isAttachmentUploading,
            showUserAvatars: true,
            showUserNames: true,
            dateIsUtc: true,
            messages: snapshot.data ?? [],
            onAttachmentPressed: _handleAtachmentPressed,
            onMessageTap: _handleMessageTap,
            onPreviewDataFetched: _handlePreviewDataFetched,
            bubbleBuilder: (Widget child, {required types.Message message, required bool nextMessageInGroup}) {
              // Check if the message is from the current user
              final bool isSender = message.author.id == FirebaseChatCore.instance.firebaseUser?.uid;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: isSender ? CustomColors.limcadPrimary : CustomColors.chatReciverBubble,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                    bottomLeft: isSender ? Radius.circular(26) : Radius.circular(0),
                    bottomRight: isSender ? Radius.circular(0) : Radius.circular(26),
                  ),
                ),
                child: child,
              );
            },
            theme:
            DefaultChatTheme(
              attachmentButtonIcon: Icon(
                Icons.attach_file_sharp,
                color: context.colorScheme.onSurface, // Send icon consistent with text
              ),
              backgroundColor: Colors.transparent,
              primaryColor: CustomColors.limcadPrimary, // Primary color for sent messages
              secondaryColor: CustomColors.limcardSecondary, // Secondary color for received messages
              inputBackgroundColor: context.colorScheme.onBackground.withOpacity(0.9), // Slight transparency for modern look
              inputTextColor: context.colorScheme.onSurface, // Consistent text color
              sendingIcon: Icon(
                Icons.send,
                color: context.colorScheme.onSurface, // Send icon consistent with text
              ),
              inputTextCursorColor: context.colorScheme.onSurface, // Cursor matches input text

              receivedMessageBodyTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: 18, // Larger for better readability
                fontWeight: FontWeight.w500,
                height: 1.6, // More line height for spaciousness
              ),

              sentMessageBodyTextStyle: TextStyle(
                color: context.colorScheme.onBackground,
                fontSize: 18, // Consistent size for sent messages
                fontWeight: FontWeight.w500,
                height: 1.6,
              ),
              dateDividerTextStyle: TextStyle(
                color: CustomColors.limcardSecondary2,
                fontSize: 13, // Slightly larger for legibility
                fontWeight: FontWeight.w700, // Slightly reduced weight for elegance
                height: 1.4,
              ),
              inputTextStyle: TextStyle(
                fontSize: 17, // Slightly larger text for input
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: context.colorScheme.onSurface,
              ),
              inputTextDecoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12), // More padding for touch comfort
                isCollapsed: true,
                fillColor: context.colorScheme.onBackground.withOpacity(0.7), // Softer fill
              ),
              inputBorderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            onSendPressed: _handleSendPressed,
            user: types.User(
              id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
            ),
          ),
        ),
      )



    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title:  Row(
        children: [
          BackButton(),

          SizedBox(width: 16 * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kristin Watson",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: () {},
        ),
        const SizedBox(width: 16 / 2),
      ],
    );
  }
}