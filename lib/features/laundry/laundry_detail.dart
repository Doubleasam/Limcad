import 'package:flutter/material.dart';
import 'package:limcad/features/dashboard/model/laundry_model.dart';
import 'package:limcad/features/laundry/components/ServiceDetail/AboutComponent.dart';
import 'package:limcad/features/laundry/components/ServiceDetail/ServicesComponent.dart';
import 'package:limcad/features/laundry/model/laundry_vm.dart';
import 'package:limcad/features/laundry/select_clothe.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/features/order/review.dart';
import 'package:limcad/features/order/review_page.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/galley_widget.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';

class LaundryDetailScreen extends StatefulWidget {
  static String tag = '/LSServiceDetailScreen';

  final LaundryItem? laundry;

  const LaundryDetailScreen({Key? key, this.laundry}) : super(key: key);

  @override
  LaundryDetailScreenState createState() => LaundryDetailScreenState();
}

class LaundryDetailScreenState extends State<LaundryDetailScreen> {
  late LaundryVM model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LaundryVM>.reactive(
        viewModelBuilder: () => LaundryVM(),
        onViewModelReady: (model) {
          this.model = model;
          model.context = context;
          model.init(context, LaundryOption.about, widget.laundry);
        },
        builder: (BuildContext context, model, child) => Scaffold(
              body:
              DefaultTabController(
                length: 4,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        leading: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: CustomColors.limcadPrimary,
                                  size: 17,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.share,
                                    color: CustomColors.limcadPrimary,
                                    size: 17,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.favorite_outline,
                                    color: CustomColors.limcadPrimary,
                                    size: 17,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          )
                        ],
                        pinned: true,
                        elevation: 0.5,
                        expandedHeight: 430,
                        flexibleSpace: FlexibleSpaceBar(
                          titlePadding:
                              EdgeInsets.only(bottom: 66, left: 30, right: 50),
                          collapseMode: CollapseMode.parallax,
                          title: Text(
                            '',
                            style: boldTextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ).hideIf(!innerBoxIsScrolled),
                          background: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  placeHolderWidget( height: 300,
                                      width: context.width(),
                                      fit: BoxFit.cover),
                                  Container(
                                    height: 300,
                                    width: context.width(),
                                    color: black.withOpacity(0.6),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 20,
                                      width: 64,
                                      decoration: BoxDecoration(
                                          color: CustomColors.limcardSecondary2,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Text('Laundry',
                                          textAlign: TextAlign.center,
                                          style: secondaryTextStyle(
                                            color: CustomColors.limcadPrimary,
                                            size: 12,
                                          ))),
                                  Row(
                                    children: [
                                      RatingBarWidget(
                                        rating: 2.5,
                                        size: 10,
                                        disable: true,
                                        onRatingChanged: (aRating) {
                                          // rating = aRating;
                                        },
                                      ),
                                      4.width,
                                      Text('4.5 (33 Reviews)',
                                          style: secondaryTextStyle(
                                              color: Colors.black, size: 9)),
                                    ],
                                  )
                                ],
                              ).paddingSymmetric(horizontal: 16, vertical: 16),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.laundry?.name ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: boldTextStyle(
                                            size: 24,
                                            color: Colors.black,
                                          )),
                                      4.height,
                                      Text(widget.laundry?.address ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: secondaryTextStyle(
                                              color: Colors.black38, size: 14)),
                                      4.height,
                                    ],
                                  ).expand(),
                                ],
                              ).padding(left: 16, right: 16, bottom: 32),
                            ],
                          ),
                        ),
                        bottom: TabBar(
                          labelStyle:
                              boldTextStyle(color: CustomColors.limcadPrimary),
                          labelColor: CustomColors.limcadPrimary,
                          unselectedLabelColor: black,
                          unselectedLabelStyle:
                              boldTextStyle(color: CustomColors.blackPrimary),
                          indicatorColor: CustomColors.limcadPrimary,
                          indicatorPadding:
                              EdgeInsets.only(left: 16, right: 16),
                          indicatorWeight: 3,
                          isScrollable: false,
                          tabs: [
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('About',
                                    style: primaryTextStyle(
                                        size: 14, weight: FontWeight.w500)),
                              ),
                            ),
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Services',
                                    style: primaryTextStyle(
                                        size: 14, weight: FontWeight.w500)),
                              ),
                            ),
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Gallery',
                                    style: primaryTextStyle(
                                        size: 14, weight: FontWeight.w500)),
                              ),
                            ),
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Reviews',
                                    style: primaryTextStyle(
                                        size: 14, weight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ];
                  },
                  body: TabBarView(
                    children: [
                      AboutComponent(laundry:  model.laundry),
                       ServicesComponent(laundry:  model.laundry),
                      GalleryWidget(laundry:  model.laundry),
                      ReviewScreen(laundry:  model.laundry)
                    ],
                  ),
                ),
              ),
          bottomNavigationBar: Container(
            decoration: boxDecorationWithShadow(backgroundColor: context.cardColor),
            padding: EdgeInsets.only(left: 16, bottom: 40, right: 16),
            child: ElevatedButton(onPressed: () {    NavigationService.pushScreen(context,
                screen: SelectClothesPage(laundry: model.laundry,), withNavBar: true); }, child: Text('Book service now',
                style: primaryTextStyle(size: 16, weight: FontWeight.w500, color: white)),
            ),
          ),
            ));
  }
}
