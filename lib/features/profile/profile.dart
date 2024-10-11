import 'package:flutter/material.dart';
import 'package:limcad/features/giftcards/selected_card_screen.dart';
import 'package:limcad/features/laundry/components/ServiceDetail/CreateService.dart';
import 'package:limcad/features/laundry/laundry_detail.dart';
import 'package:limcad/features/onboarding/get_started.dart';
import 'package:limcad/features/onboarding/user_type.dart';
import 'package:limcad/features/profile/business_detail.dart';
import 'package:limcad/features/profile/faq.dart';
import 'package:limcad/features/profile/model/profile_view_model.dart';
import 'package:limcad/features/profile/profile_address.dart';
import 'package:limcad/features/profile/profile_details.dart';
import 'package:limcad/features/profile/referrals.dart';
import 'package:limcad/features/wallet/wallet.dart';
import 'package:limcad/resources/routes.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';

class ProfilePage extends StatefulWidget {
  final String? role;
  UserType userType;
  ProfilePage({super.key, this.role, required this.userType});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "John Doe"; // Initial name
  late ProfileVM model;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ProfileVM(),
      onViewModelReady: (model) {
        this.model = model;
        model.context = context;
        model.init(context, ProfileOption.fetchProfile, widget.userType);
      },
      builder: (BuildContext context, model, child) => DefaultScaffold2(
        showAppBar: false,
        backgroundColor: CustomColors.backgroundColor,
        body: SingleChildScrollView(
          // If content might overflow
          child: Column(
            children: [
              // Profile Picture and Info
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(
                        AssetUtil.user,
                      ),
                    ),
                    Text(model.profileResponse?.name ?? "John Doe",
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
              ).paddingTop(40),

              // "Personal" Section
              _buildSection("Personal", [
                ListTile(
                  onTap: () {
                    NavigationService.pushScreen(context,
                        screen: ProfileDetailsPage(userType: widget.userType),
                        withNavBar: true);
                  },
                  title: Text("Profile Details"),
                  leading: Icon(Icons.person),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 12,
                  ),
                ),
                Divider(
                  thickness: 0.5,
                ).paddingSymmetric(horizontal: 16),
                // ListTile(
                //   onTap: () {
                //     NavigationService.pushScreen(context,
                //         screen: ProfileAddressPage(userType: widget.userType),
                //         withNavBar: true);
                //   },
                //   title: Text("Address"),
                //   leading: Icon(Icons.home),
                //   trailing: Icon(
                //     Icons.arrow_forward_ios_sharp,
                //     size: 12,
                //   ),
                // ),
                // Divider(
                //   thickness: 0.5,
                // ).paddingSymmetric(horizontal: 16),
                ListTile(
                  onTap: () {
                    NavigationService.pushScreen(context,
                        screen: WalletPage(), withNavBar: true);
                  },
                  title: Text("Wallet"),
                  leading: Icon(Icons.account_balance_wallet),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 12,
                  ),
                ),
              ]),

              _buildSection("Services", [
                Column(
                  children: [
                    ListTile(
                      onTap: () {
                        userTypeToString(widget.userType) == "BUSINESS"
                            ? NavigationService.pushScreen(context,
                            screen: BusinessDetailScreen(), withNavBar: true)
                            : NavigationService.pushScreen(context,
                            screen: LaundryDetailScreen(), withNavBar: true);
                      },
                      title: const Text("Description"),
                      leading: const Icon(Icons.wallet_giftcard),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 12,
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                    ).paddingSymmetric(horizontal: 16),
                  ],
                ).hideIf(userTypeToString(widget.userType) != "BUSINESS"),
                ListTile(
                  onTap: () {},
                  title: const Text("Staff Management"),
                  leading: const Icon(Icons.wallet_giftcard),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 12,
                  ),
                ).hideIf(userTypeToString(widget.userType) != "BUSINESS"),
                const Divider(
                  thickness: 0.5,
                )
                    .paddingSymmetric(horizontal: 16)
                    .hideIf(userTypeToString(widget.userType) != "BUSINESS"),
                ListTile(
                  onTap: () {
                    NavigationService.pushScreen(context,
                        screen: CreateServicesComponent());
                  },
                  title: const Text("Services"),
                  leading: const Icon(Icons.wallet_giftcard),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 12,
                  ),
                ).hideIf(userTypeToString(widget.userType) != "BUSINESS"),
                const Divider(
                  thickness: 0.5,
                )
                    .paddingSymmetric(horizontal: 16)
                    .hideIf(userTypeToString(widget.userType) != "BUSINESS"),
                ListTile(
                  onTap: () {
                    NavigationService.pushScreen(context,
                        screen: ReferralsScreen(), withNavBar: true);
                  },
                  title: const Text("Referrals"),
                  leading: const Icon(Icons.card_giftcard_outlined),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 12,
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                ).paddingSymmetric(horizontal: 16),
                ListTile(
                  onTap: () {
                    NavigationService.pushScreen(context,
                        screen: SelectedCardScreen(), withNavBar: true);
                  },
                  title: Text("Gift Cards"),
                  leading: Icon(Icons.wallet_giftcard),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 12,
                  ),
                ),
              ]),

              _buildSection("More", [
                ListTile(
                  onTap: () {
                    NavigationService.pushScreen(context,
                        screen: FAQScreen(), withNavBar: true);
                  },
                  title: Text("FAQ"),
                  leading: Icon(Icons.person),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 12,
                  ),
                ),
                Divider(
                  thickness: 0.5,
                ).paddingSymmetric(horizontal: 16),

                ListTile(
                  onTap: () {

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserTypePage()),
                            (Route<dynamic> route) => false
                    );
                  },
                  title: Text("Log Out"),
                  leading: Icon(Icons.logout, color: Colors.red,),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 12,
                  ),
                ),
                Divider(
                  thickness: 0.5,
                ).paddingSymmetric(horizontal: 16),
                ListTile(
                  title: Text("Get help"),
                  leading: Icon(Icons.home),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 12,
                  ),
                ),
                Divider(
                  thickness: 0.5,
                ).paddingSymmetric(horizontal: 16),
                ListTile(
                  title: Text("Legal information"),
                  leading: Icon(Icons.account_balance_wallet),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 12,
                  ),
                ),
              ]),
              // ... Similar for "Services" and "More"
            ],
          ).paddingSymmetric(vertical: 45, horizontal: 16),
        ),
      ),
    );
  }

  String userTypeToString(UserType type) {
    switch (type) {
      case UserType.personal:
        return 'PERSONAL';
      case UserType.business:
        return 'BUSINESS';
      default:
        return '';
    }
  }

  void _showEditNameDialog() {
    TextEditingController _controller = TextEditingController(text: _name);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit Name"),
            content: TextField(
              controller: _controller,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              TextButton(
                onPressed: () {
                  setState(() {
                    _name = _controller.text;
                    Navigator.pop(context);
                  });
                },
                child: Text('Save'),
              ),
            ],
          );
        });
  }

  // Helper to build sections
  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: [
              ...items,
            ],
          ),
        )
      ],
    );
  }
}
