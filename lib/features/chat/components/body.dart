//
// import 'package:flutter/material.dart';
// import 'package:limcad/features/chat/components/filled_outline_button.dart';
// import 'package:limcad/features/chat/message_screen.dart';
// import 'package:limcad/features/chat/models/chat.dart';
// import 'package:limcad/resources/utils/custom_colors.dart';
//
// import 'chat_card.dart';
//
// class Body extends StatelessWidget {
//   const Body({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: chatsData.length,
//             itemBuilder: (context, index) => ChatCard(
//               chat: chatsData[index],
//               press: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const MessagesScreen(),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }