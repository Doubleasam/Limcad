import 'package:flutter/material.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:nb_utils/nb_utils.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String email;
  final String profileImageUrl;
  final int rating;
  final String timeAgo;
  final String reviewText;
  final bool isVerified;

  const ReviewCard(
      {Key? key,
      required this.name,
      required this.email,
      required this.profileImageUrl,
      required this.rating,
      required this.timeAgo,
      required this.reviewText,
      required this.isVerified})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(profileImageUrl),
            ).paddingRight(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.verified,
                      color: Colors.green,
                      size: 16,
                    ).hideIf(!isVerified),
                  ],
                ),
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: rating >= 1 ? Colors.amber : Colors.grey,
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: rating >= 2 ? Colors.amber : Colors.grey,
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: rating >= 3 ? Colors.amber : Colors.grey,
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: rating >= 4 ? Colors.amber : Colors.grey,
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: rating >= 5 ? Colors.amber : Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
                Text(
                  timeAgo,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ).padding(bottom: 10),
        Text(
          reviewText,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
