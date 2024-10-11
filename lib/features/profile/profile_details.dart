import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:limcad/features/onboarding/get_started.dart';
// import 'package:intl/date_symbol_data_http_request.dart';
import 'package:limcad/features/profile/model/profile_view_model.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/size_util.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class ProfileDetailsPage extends StatefulWidget {
  UserType userType;
  ProfileDetailsPage({super.key, required this.userType});
  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
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
      builder: (BuildContext context, model, child) {
        return DefaultScaffold2(
          showAppBar: true,
          title: 'Profile details',
          backgroundColor: white,
          body: SingleChildScrollView(
            // If content might overflow
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      color: CustomColors.backgroundColor,
                      child: ListTile(
                        title: Text(
                          widget.userType == UserType.business
                              ? "Company Name"
                              : "Account name",
                          style: const TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          model.profileResponse?.name ?? "John Doe",
                          style: const TextStyle(
                              fontSize: 14,
                              color: grey,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            IconsaxBold.edit_2,
                            size: 20,
                          ),
                          onPressed: () {
                            model.showUpdateNameModal(
                                context, BottomSheetOption.accountName);
                          },
                        ),
                      ),
                    ),
                    16.height,
                    Container(
                      color: CustomColors.backgroundColor,
                      child: ListTile(
                        title: const Text(
                          "Phone number",
                          style: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          model.profileResponse?.phoneNumber ?? "0800000000",
                          style: const TextStyle(
                              fontSize: 14,
                              color: grey,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            IconsaxBold.edit_2,
                            size: 20,
                          ),
                          onPressed: () {
                            model.showUpdateNameModal(
                                context, BottomSheetOption.phoneNumber);
                          },
                        ),
                      ),
                    ),
                    16.height,
                    Container(
                        color: CustomColors.backgroundColor,
                        child: ListTile(
                          title: const Text(
                            "Email address",
                            style: TextStyle(
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            model.profileResponse?.email ?? "johndoe@gmail.com",
                            style: const TextStyle(
                                fontSize: 14,
                                color: grey,
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              IconsaxBold.edit_2,
                              size: 20,
                            ),
                            onPressed: () {
                              model.showUpdateNameModal(
                                  context, BottomSheetOption.emailAddress);
                            },
                          ),
                        )),
                    16.height,
                    Container(
                      color: CustomColors.backgroundColor,
                      child: ListTile(
                        title: const Text(
                          "Date of birth",
                          style: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text(
                          "July 20th",
                          style: TextStyle(
                              fontSize: 14,
                              color: grey,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            IconsaxBold.edit_2,
                            size: 20,
                          ),
                          onPressed: () {
                            model.showUpdateNameModal(
                                context, BottomSheetOption.dob);
                          },
                        ),
                      ),
                    ).hideIf(widget.userType == UserType.business),
                    56.height.hideIf(widget.userType == UserType.business),
                    Container(
                      height: 72,
                      color: CustomColors.backgroundColor,
                      child: Center(
                        child: const ListTile(
                          title: Text(
                            "Sign out",
                            style: TextStyle(
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.w500),
                          ),
                          leading: Icon(Icons.logout),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    16.height,
                    Container(
                      height: 72,
                      color: CustomColors.backgroundColor,
                      child: Center(
                        child: const ListTile(
                          title: Text(
                            "Delete account",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.w500),
                          ),
                          leading: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ).paddingSymmetric(vertical: 45, horizontal: 16),
          ),
        );
      },
    );
  }

  void _showEditNameDialog() {
    TextEditingController _controller = TextEditingController(text: _name);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit Name"),
            content: TextField(
              controller: _controller,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                onPressed: () {
                  setState(() {
                    _name = _controller.text;
                    Navigator.pop(context);
                  });
                },
                child: const Text('Save'),
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
          child:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
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
