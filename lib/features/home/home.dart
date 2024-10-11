//
//
// import 'package:flutter/material.dart';
// import 'package:limcad/features/auth/models/signup_vm.dart';
// import 'package:limcad/resources/utils/assets/asset_util.dart';
// import 'package:limcad/resources/utils/custom_colors.dart';
// import 'package:limcad/resources/utils/extensions/widget_extension.dart';
// import 'package:limcad/resources/widgets/default_scafold.dart';
// import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';
// import 'package:limcad/resources/widgets/view_utils/phone_textfield.dart';
// import 'package:stacked/stacked.dart';
//
// class HomeScreenPage extends StatefulWidget {
//   static const String routeName = "/home";
//
//   const HomeScreenPage({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreenPage> createState() => _HomeScreenPageState();
// }
//
// class _HomeScreenPageState extends State<HomeScreenPage> {
//   late AuthVM model;
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<AuthVM>.reactive(
//         viewModelBuilder: () => AuthVM(),
//         onViewModelReady: (model) {
//           this.model = model;
//           model.context = context;
//           model.init(context);
//         },
//         builder: (BuildContext context, model, child) =>
//             DefaultScaffold(
//               showAppBar: true,
//               includeAppBarBackButton:false,
//               overrideBackButton: () {
//                 model.exitApp(context);
//               },
//               title: model.title,
//               busy: model.loading,
//               body: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(child: Image.asset(AssetUtil.limcadLogo, scale: 1.0),),
//                     Center(
//                       child: Text(
//                         "Sign up",
//                         overflow: TextOverflow.ellipsis,
//                         style: Theme.of(context).textTheme.headlineMedium!.merge(
//                           const TextStyle(color: CustomColors.limcadPrimary),
//                         ),
//                       ).padding(bottom: 8, top: 30),
//                     ),
//                     Center(
//                       child: Text(
//                         "Let’s get started with your account",
//                         style: Theme.of(context).textTheme.bodyMedium!,
//                       ).padding(bottom: 20),
//                     ),
//                     Form(
//                       key: model.formKey,
//                       onChanged: model.onFormKeyChanged,
//                       autovalidateMode: AutovalidateMode.disabled,
//                       child: Column(
//                         children: [
//                           CustomTextFields(
//                             controller: model.emailController,
//                             keyboardType: TextInputType.emailAddress,
//                             label: "Email Address",
//                             showLabel: true,
//                             autocorrect: false,
//                             //validate: (value) => ValidationUtil.validateLastName(value),
//                             onSave: (value) => model.email = value,
//                           ).padding(bottom: 20),
//                           PhoneTextField(
//                             hideCountryCode: true,
//                             controller: model.phoneNumberController,
//                             label: "Phone Number",
//                             showLabel: true,
//                             // validate: (value) => ValidationUtil.validatePhoneNumber(value),
//                             onSave: (value) => model.phoneNumberController.text = value ?? "",
//                           ).padding(bottom: 20),
//
//                           CustomTextFields(
//                             controller: model.firstNameController,
//                             keyboardType: TextInputType.name,
//                             label: "First Name",
//                             showLabel: true,
//                             formatter: InputFormatter.stringOnly,
//                             autocorrect: false,
//                             //validate: (value) => ValidationUtil.validateLastName(value),
//                             onSave: (value) => model.firstNameController.text = value,
//                           ).padding(bottom: 20),
//
//                           CustomTextFields(
//                             controller: model.lastNameController,
//                             keyboardType: TextInputType.name,
//                             label: "Last Name",
//                             showLabel: true,
//                             formatter: InputFormatter.stringOnly,
//                             autocorrect: false,
//                             //validate: (value) => ValidationUtil.validateLastName(value),
//                             onSave: (value) => model.lastNameController.text = value,
//                           ).padding(bottom: 20),
//
//                           ElevatedButton(
//                             onPressed: !model.isButtonEnabled
//                                 ? null
//                                 : () {
//                               FocusScope.of(context).unfocus();
//                               model.formKey.currentState!.save();
//
//                               model.proceed();
//                             },
//                             child: const Text("Create Account"),
//                           )
//                         ],
//                       ).paddingSymmetric(horizontal: 16, vertical: 20),
//                     ),
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Already have an account? "),
//                         TextButton(
//                             onPressed: null,
//                             child:  Text(
//                               'Sign in',
//                               style: TextStyle(
//                                   decoration: TextDecoration.underline,
//                                   color: CustomColors.rpBlue),
//                             )),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ));
//   }
//
// // ... (Add dispose method to clean up controllers)
// }