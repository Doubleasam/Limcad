import 'package:flutter/material.dart';
import 'package:limcad/features/profile/referral_history_screen.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/app_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ReferralsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold2(
      showAppBar: true,
      includeAppBarBackButton: true,
      title: "Referrals",
      backgroundColor: CustomColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: CustomColors.limcardFaint.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      AssetUtil.referralGift,
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: CustomColors.limcadPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'wcjohn-qgi',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.copy, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            '|',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.share, color: Colors.white, size: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Invite someone to get',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ).paddingBottom(16),
                ListTile(
                  horizontalTitleGap: 8,
                  // leading: Container(
                  //     decoration: const BoxDecoration(
                  //         shape: BoxShape.circle, color: CustomColors.backgroundColor),
                  //     width: 45,
                  //     height: 45,
                  //     child:   Center(
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             border: Border.all(
                  //                 color: CustomColors.limcadPrimary,
                  //                 width: 1.3),
                  //             shape: BoxShape.circle),
                  //         width: 16,
                  //         height: 16,
                  //         child: Center(
                  //           child: Container(
                  //             decoration: const BoxDecoration(
                  //                 color: CustomColors.limcadPrimary,
                  //                 shape: BoxShape.circle),
                  //             width: 11,
                  //             height: 11,
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Text('₦ 300',
                              overflow: TextOverflow.ellipsis,
                              style: primaryTextStyle(
                                  size: 16,
                                  weight: FontWeight.w500)),

                        ],
                      ),
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('when they make their first order',
                              style: primaryTextStyle(
                                  size: 12,
                                  color: black.withOpacity(0.6),
                                  weight: FontWeight.w400))
                              .paddingTop(8),
                        ],
                      ),
                    ],
                  ),
                ).paddingBottom(16),
                ListTile(
                  horizontalTitleGap: 8,
                  // leading: Container(
                  //     decoration: const BoxDecoration(
                  //         shape: BoxShape.circle, color: CustomColors.backgroundColor),
                  //     width: 45,
                  //     height: 45,
                  //     child:   Center(
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             border: Border.all(
                  //                 color: CustomColors.limcadPrimary,
                  //                 width: 1.3),
                  //             shape: BoxShape.circle),
                  //         width: 16,
                  //         height: 16,
                  //         child: Center(
                  //           child: Container(
                  //             decoration: const BoxDecoration(
                  //                 color: CustomColors.limcadPrimary,
                  //                 shape: BoxShape.circle),
                  //             width: 11,
                  //             height: 11,
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Text('₦ 300',
                              overflow: TextOverflow.ellipsis,
                              style: primaryTextStyle(
                                  size: 16,
                                  weight: FontWeight.w500)),

                        ],
                      ),
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('when they make their first order',
                              style: primaryTextStyle(
                                  size: 12,
                                  color: black.withOpacity(0.6),
                                  weight: FontWeight.w400))
                              .paddingTop(8),
                        ],
                      ),
                    ],
                  ),
                ).paddingBottom(16),
                ListTile(
                  horizontalTitleGap: 8,
                  // leading: Container(
                  //     decoration: const BoxDecoration(
                  //         shape: BoxShape.circle, color: CustomColors.backgroundColor),
                  //     width: 45,
                  //     height: 45,
                  //     child:   Center(
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             border: Border.all(
                  //                 color: CustomColors.limcadPrimary,
                  //                 width: 1.3),
                  //             shape: BoxShape.circle),
                  //         width: 16,
                  //         height: 16,
                  //         child: Center(
                  //           child: Container(
                  //             decoration: const BoxDecoration(
                  //                 color: CustomColors.limcadPrimary,
                  //                 shape: BoxShape.circle),
                  //             width: 11,
                  //             height: 11,
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Text('₦ 300',
                              overflow: TextOverflow.ellipsis,
                              style: primaryTextStyle(
                                  size: 16,
                                  weight: FontWeight.w500)),

                        ],
                      ),
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('when they make their first order',
                              style: primaryTextStyle(
                                  size: 12,
                                  color: black.withOpacity(0.6),
                                  weight: FontWeight.w400))
                              .paddingTop(8),
                        ],
                      ),
                    ],
                  ),
                ).paddingBottom(16),
                
              ],
            ).paddingSymmetric(horizontal: 16, vertical: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'The person you referred get',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ).paddingBottom(16),
                ListTile(
                  horizontalTitleGap: 8,
                  // leading: Container(
                  //     decoration: const BoxDecoration(
                  //         shape: BoxShape.circle, color: CustomColors.backgroundColor),
                  //     width: 45,
                  //     height: 45,
                  //     child:   Center(
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             border: Border.all(
                  //                 color: CustomColors.limcadPrimary,
                  //                 width: 1.3),
                  //             shape: BoxShape.circle),
                  //         width: 16,
                  //         height: 16,
                  //         child: Center(
                  //           child: Container(
                  //             decoration: const BoxDecoration(
                  //                 color: CustomColors.limcadPrimary,
                  //                 shape: BoxShape.circle),
                  //             width: 11,
                  //             height: 11,
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Text('₦ 300',
                              overflow: TextOverflow.ellipsis,
                              style: primaryTextStyle(
                                  size: 16,
                                  weight: FontWeight.w500)),

                        ],
                      ),
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('when they make their first order',
                              style: primaryTextStyle(
                                  size: 12,
                                  color: black.withOpacity(0.6),
                                  weight: FontWeight.w400))
                              .paddingTop(8),
                        ],
                      ),
                    ],
                  ),
                ).paddingBottom(16),
                ListTile(
                  horizontalTitleGap: 8,
                  // leading: Container(
                  //     decoration: const BoxDecoration(
                  //         shape: BoxShape.circle, color: CustomColors.backgroundColor),
                  //     width: 45,
                  //     height: 45,
                  //     child:   Center(
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             border: Border.all(
                  //                 color: CustomColors.limcadPrimary,
                  //                 width: 1.3),
                  //             shape: BoxShape.circle),
                  //         width: 16,
                  //         height: 16,
                  //         child: Center(
                  //           child: Container(
                  //             decoration: const BoxDecoration(
                  //                 color: CustomColors.limcadPrimary,
                  //                 shape: BoxShape.circle),
                  //             width: 11,
                  //             height: 11,
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Text('₦ 300',
                              overflow: TextOverflow.ellipsis,
                              style: primaryTextStyle(
                                  size: 16,
                                  weight: FontWeight.w500)),

                        ],
                      ),
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('when they make their first order',
                              style: primaryTextStyle(
                                  size: 12,
                                  color: black.withOpacity(0.6),
                                  weight: FontWeight.w400))
                              .paddingTop(8),
                        ],
                      ),
                    ],
                  ),
                ).paddingBottom(16),
                ListTile(
                  horizontalTitleGap: 8,
                  // leading: Container(
                  //     decoration: const BoxDecoration(
                  //         shape: BoxShape.circle, color: CustomColors.backgroundColor),
                  //     width: 45,
                  //     height: 45,
                  //     child:   Center(
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             border: Border.all(
                  //                 color: CustomColors.limcadPrimary,
                  //                 width: 1.3),
                  //             shape: BoxShape.circle),
                  //         width: 16,
                  //         height: 16,
                  //         child: Center(
                  //           child: Container(
                  //             decoration: const BoxDecoration(
                  //                 color: CustomColors.limcadPrimary,
                  //                 shape: BoxShape.circle),
                  //             width: 11,
                  //             height: 11,
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Text('₦ 300',
                              overflow: TextOverflow.ellipsis,
                              style: primaryTextStyle(
                                  size: 16,
                                  weight: FontWeight.w500)),

                        ],
                      ),
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('when they make their first order',
                              style: primaryTextStyle(
                                  size: 12,
                                  color: black.withOpacity(0.6),
                                  weight: FontWeight.w400))
                              .paddingTop(8),
                        ],
                      ),
                    ],
                  ),
                ).paddingBottom(16),

              ],
            ).paddingSymmetric(horizontal: 16, vertical: 16),
            SizedBox(height: 32),
            ListTile(
              title: Text(
                'Check your referral history',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReferralHistoryScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
