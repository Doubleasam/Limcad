import 'package:flutter/material.dart';
import 'package:limcad/features/dashboard/model/laundry_model.dart';
import 'package:limcad/features/dashboard/widgets/review_card.dart';
import 'package:limcad/features/laundry/model/laundry_vm.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';

class ReviewScreen extends StatefulWidget {
  final LaundryItem? laundry;

  const ReviewScreen({Key? key, this.laundry}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late LaundryVM model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LaundryVM(),
      onViewModelReady: (model) {
        this.model = model;
        model.context = context;
        model.init(context, LaundryOption.review, widget.laundry);
      },
      builder: (BuildContext context, model, child) {
        return DefaultScaffold2(
          showAppBar: false,
          body: ListView.builder(
            itemCount: model.reviews?.length ?? 0,
            itemBuilder: (context, index) {
              final review = model.reviews?[index];
              final name = review?.customer?.name ?? 'Anonymous';
              final email = review?.customer?.email ?? 'No email provided';
              const profileImageUrl = 'default_profile_image_url';
              final rating = review?.rating ?? 0;
              final timeAgo = _calculateTimeAgo(
                  review?.createdAt ?? DateTime.now().toString());
              final reviewText =
                  review?.reviewText ?? 'No review text provided';
              final isVerified = review?.customer?.verified ?? false;

              return ReviewCard(
                name: name,
                email: email,
                profileImageUrl: profileImageUrl,
                rating: rating,
                timeAgo: timeAgo,
                reviewText: reviewText,
                isVerified: isVerified,
              ).paddingBottom(20);
            },
          ).paddingSymmetric(horizontal: 16, vertical: 20),
        );
      },
    );
  }

  String _calculateTimeAgo(String createdAt) {
    final createdTime = DateTime.parse(createdAt);
    final difference = DateTime.now().difference(createdTime);

    if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 1) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
