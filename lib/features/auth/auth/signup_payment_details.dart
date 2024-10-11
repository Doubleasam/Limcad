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
// class SignupPaymentDetails extends StatefulWidget {
//   static const String routeName = "/signup";
//
//   const SignupPaymentDetails({Key? key}) : super(key: key);
//
//   @override
//   State<SignupPaymentDetails> createState() => _SignupPaymentDetailsState();
// }
//
// class _SignupPaymentDetailsState extends State<SignupPaymentDetails> {
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
//               includeAppBarBackButton:true,
//               title: "",
//               busy: model.loading,
//               body: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Image.asset(AssetUtil.limcadLogo, scale: 1.0),
//                         Text(
//                           "Add payment details",
//                           overflow: TextOverflow.ellipsis,
//                           style: Theme.of(context).textTheme.headlineMedium!.merge(
//                             const TextStyle(color: CustomColors.limcadPrimary),
//                           ),
//                         ).padding(bottom: 8, top: 30),
//                         Text(
//                           "Securely add your details seamless transactions. Ensure accuracy to avoid errors",
//                           style: Theme.of(context).textTheme.bodyMedium!,
//                         ).padding(bottom: 20),
//                       ],
//                     ).paddingSymmetric(horizontal: 16),
//                     Form(
//                       key: model.formKey,
//                       onChanged: model.onFormKeyChanged,
//                       autovalidateMode: AutovalidateMode.disabled,
//                       child: Column(
//                         children: [
//
//                           CustomTextFields(
//                             controller: model.bankNameController,
//                             keyboardType: TextInputType.name,
//                             label: "Bank Name",
//                             showLabel: true,
//                             formatter: InputFormatter.stringOnly,
//                             autocorrect: false,
//                             //validate: (value) => ValidationUtil.validateLastName(value),
//                             onSave: (value) => model.bankNameController.text = value,
//                           ).padding(bottom: 20),
//
//                           CustomTextFields(
//                             controller: model.accountName,
//                             keyboardType: TextInputType.name,
//                             label: "Account Holder Name",
//                             showLabel: true,
//                             formatter: InputFormatter.stringOnly,
//                             autocorrect: false,
//                             //validate: (value) => ValidationUtil.validateLastName(value),
//                             onSave: (value) => model.accountName.text = value,
//                           ).padding(bottom: 20),
//
//                           CustomTextFields(
//                             controller: model.accountNumber,
//                             keyboardType: TextInputType.name,
//                             label: "Account Number",
//                             showLabel: true,
//                             formatter: InputFormatter.stringOnly,
//                             autocorrect: false,
//                             //validate: (value) => ValidationUtil.validateLastName(value),
//                             onSave: (value) => model.accountNumber.text = value,
//                           ).padding(bottom: 20),
//
//                           CustomTextFields(
//                             controller: model.routingNumber,
//                             keyboardType: TextInputType.name,
//                             label: "Routing Number (If Applicable)",
//                             showLabel: true,
//                             formatter: InputFormatter.stringOnly,
//                             autocorrect: false,
//                             //validate: (value) => ValidationUtil.validateLastName(value),
//                             onSave: (value) => model.routingNumber.text = value,
//                           ).padding(bottom: 20),
//
//                           CustomTextFields(
//                             controller: model.taxNumber,
//                             keyboardType: TextInputType.name,
//                             label: "Tax Payer ID (Optional)",
//                             showLabel: true,
//                             formatter: InputFormatter.stringOnly,
//                             autocorrect: false,
//                             //validate: (value) => ValidationUtil.validateLastName(value),
//                             onSave: (value) => model.taxNumber.text = value,
//                           ).padding(bottom: 20),
//                           Text("limcad will file 5% with holding taxes on your behalf when you receive payments ", style: Theme.of(context).textTheme.bodyMedium!).paddingSymmetric(horizontal: 16).padding(bottom: 20),
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
//                   ],
//                 ),
//               ),
//             ));
//   }
//
// // ... (Add dispose method to clean up controllers)
// }