import 'package:camera/camera.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:limcad/features/auth/models/signup_request.dart';
import 'package:limcad/features/auth/models/signup_vm.dart';
import 'package:limcad/features/laundry/model/business_order_detail_response.dart';
import 'package:limcad/features/laundry/model/laundry_vm.dart';
import 'package:limcad/features/order/order_details.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/utils/validation_util.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'package:limcad/resources/widgets/view_utils/block_input_field.dart';
import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';
import 'package:limcad/resources/widgets/view_utils/phone_textfield.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';

class ReviewsPage extends StatefulWidget {
  static const String routeName = "/ReviewsPage";
  final BusinessOrderDetailResponse? businessOrderDetailsid;
  const ReviewsPage(
    this.businessOrderDetailsid, {
    Key? key,
  }) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  late LaundryVM model;
  PageController _controller = PageController(initialPage: 0, keepPage: false);
  var selectedTab = 0;

  double ratingValue = 0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LaundryVM>.reactive(
        viewModelBuilder: () => LaundryVM(),
        onViewModelReady: (model) {
          this.model = model;
          model.context = context;
          model.orderId = widget.businessOrderDetailsid?.id;
          model.init(context, LaundryOption.sendReview, null, widget.businessOrderDetailsid?.id);
        },
        builder: (BuildContext context, model, child) => DefaultScaffold2(
            showAppBar: true,
            includeAppBarBackButton: true,
            title: "Drop a review",
            backgroundColor: CustomColors.backgroundColor,
            busy: model.loading,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    width: context.width(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "How was our service?",
                          style: Theme.of(context).textTheme.bodySmall!.merge(
                              const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColors.blackPrimary)),
                          textAlign: TextAlign.center,
                        ).padding(bottom: 16),
                        RatingBarWidget(
                          rating: ratingValue,
                          size: 64,
                          defaultIconData: Icons.star_outline,
                          activeColor: CustomColors.limcadYellow,
                          onRatingChanged: (aRating) {
                            setState(() {
                              ratingValue = aRating;
                              model.ratingValue = ratingValue;
                            });
                          },
                        ).padding(bottom: 16),
                        Text(
                          "Your feedback helps us improve our services and serve you even better.",
                          style: Theme.of(context).textTheme.bodySmall!.merge(
                              const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColors.smallTextGrey)),
                          textAlign: TextAlign.center,
                        ).padding(bottom: 40),
                        CustomTextArea(
                          controller: model.instructionController,
                          label: "Drop a comment",
                          showLabel: true,
                          //labelText: "Please type instruction here, if there is any...",
                          maxLines: 5,
                          autocorrect: false,
                          //validate: (value) => ValidationUtil.validateLastName(value),
                          onSave: (value) =>
                              model.instructionController.text = value,
                        ).padding(bottom: 30),
                        ElevatedButton(
                          onPressed: ratingValue == 0
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();

                                  model.submitReview(widget.businessOrderDetailsid);
                                },
                          child: const Text(
                            "Add review",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
