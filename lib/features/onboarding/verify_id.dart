import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:limcad/features/auth/models/signup_request.dart';
import 'package:limcad/features/auth/models/signup_vm.dart';
import 'package:limcad/features/onboarding/complete_profile.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:limcad/resources/widgets/view_utils/block_input_field.dart';
import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';
import 'package:stacked/stacked.dart';

class VerifyIdPage extends StatefulWidget {
  static const String routeName = "/verifyID";
  final SignupRequest? request;

  const VerifyIdPage({Key? key, this.request}) : super(key: key);

  @override
  State<VerifyIdPage> createState() => _VerifyIdPageState();
}

class _VerifyIdPageState extends State<VerifyIdPage> {
  late AuthVM model;





  @override
  void dispose() {
    model.controller?.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthVM>.reactive(
        viewModelBuilder: () => AuthVM(),
        onViewModelReady: (model) {
          this.model = model;
          model.signupRequest = widget.request;
          model.context = context;
          model.init(context);
        },
        builder: (BuildContext context, model, child) => DefaultScaffold(
              showAppBar: true,
              includeAppBarBackButton: true,
              title: "",
              busy: model.loading,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Center(
                          child:  const Text(
                            "Verify Your Identity",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: CustomColors.blackPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 32),
                          ).padding(bottom: 8, top: 30),
                        ),
                        Center(
                          child: Text(
                            "Please provide means of identification issued by the national authority.",
                            style: Theme.of(context).textTheme.bodyMedium!,
                            textAlign: TextAlign.center,
                          ),
                        ).padding(bottom: 20),
                        idViewDoc("Scan your ID", "Scan a document issued by the federal government of Nigeria.", (){
                          model.setId(IdType.document);
                        }).padding(bottom: 24),
                        idViewNin("Add your NIN number", "", (){
                          model.setId(IdType.nin);
                        }).padding(bottom: 24),

                        const Center(
                          child: Text(
                            "Why does WakaClean need this information?.",
                            style: TextStyle(
                                color: CustomColors.limcardFaded,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ).padding(bottom: 40),
                      ],
                    ).hideIf(model.showDocumentView || model.showNinView),

                    documentView().hideIf(!model.showDocumentView),
                    ninView().hideIf(!model.showNinView),

                     ElevatedButton(
                      onPressed:  (){
                        if(model.showDocumentView){
                          model.documentVerify();
                        }else if (model.showNinView){
                          model.ninVerify();
                        }else if(model.documentVerified && model.ninVerified){
                       //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  CompleteProfilePage(request: SignupRequest(role: model.userType?.name),)));
                        }
                      },

                      child: Text(model.documentVerified && model.ninVerified ? "Get Started" : "Verify"),
                    )
                  ],
                ).paddingSymmetric(horizontal: 16, vertical: 16),
              ),
            ));
  }


  Widget documentView(){
    return  Column(
      children: [
        Center(
          child:  const Text(
            "Scan the front of your ID",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: CustomColors.blackPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 32),
          ).padding(bottom: 8, top: 30),
        ),
        Center(
          child: Text(
            "Please ensure that the identity page is completely captured.",
            style: Theme.of(context).textTheme.bodyMedium!,
            textAlign: TextAlign.center,
          ),
        ).padding(bottom: 20),

        Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          decoration:  const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child:  Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: CameraPreview(model.controller!),
            ),
          ),
        )

      ],
    );

  }


  Widget ninView(){
    return  Column(
      children: [
        Center(
          child:  const Text(
            "Enter Your NIN",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: CustomColors.blackPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 32),
          ).padding(bottom: 8, top: 30),
        ),
        Center(
          child: Text(
            "Please provide the 11 digits identification number issued by the government.",
            style: Theme.of(context).textTheme.bodyMedium!,
            textAlign: TextAlign.center,
          ),
        ).padding(bottom: 20),

        CustomTextFields(
          controller: model.ninController,
          keyboardType: TextInputType.number,
          label: "NIN",
          labelText: "Enter your NIN",
          showLabel: true,
          autocorrect: false,
          //validate: (value) => ValidationUtil.validateLastName(value),
          onSave: (value) => model.email = value,
        ).padding(bottom: 20),

      ],
    );

  }

  Widget idViewDoc(String title, String subtitle, VoidCallback onSelected ) {
    return Column(
      children: [
        Container(
          height: subtitle.isEmpty ? 144 : 200,
          width: MediaQuery.of(context).size.width,
          decoration:  const BoxDecoration(
              color: CustomColors.limcadPrimary,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child:  Column(children: [
             Container(
               width: MediaQuery.of(context).size.width,
               decoration:  const BoxDecoration(
                   color: CustomColors.limcardSecondary,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
               child: Column(
                 children: [
                   Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: CustomColors.blackPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 24),
                      ),
                      model.documentVerified ?
                      Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.greenPrimary,
                          ),
                          child: const Center(child: Icon(Icons.check, size: 14, color: Colors.white, ),)
                      )
                          :
                      GestureDetector(
                        onTap: onSelected,
                        child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomColors.limcadPrimary,
                            ),
                            child: const Center(child: Icon(Icons.add, size: 14, color: Colors.white, ),)
                        ),
                      )
            ],).padding(left: 22, top: 20, right: 22),
             SizedBox(
                    height: subtitle.isEmpty ? 11 : 50,
                    child: Text(subtitle,
                      style: const TextStyle(
                          color: CustomColors.blackPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
            ).padding(left: 22, top: 8, right: 22),
                   const SizedBox(height: 24,).hideIf(subtitle.isEmpty)
                 ],
               ),
             ),
            const Row(children: [
              Icon(Icons.lock, color: Colors.white, size: 24,),
              Text(
                " Your personal details are fully protected",
                style: TextStyle(
                    color: CustomColors.kWhite,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              )
            ],).padding(top: 22, left: 20, right: 20)
          ],),
        )
      ],
    );
  }


  Widget idViewNin(String title, String subtitle, VoidCallback onSelected ) {
    return Column(
      children: [
        Container(
          height: subtitle.isEmpty ? 144 : 200,
          width: MediaQuery.of(context).size.width,
          decoration:  const BoxDecoration(
              color: CustomColors.limcadPrimary,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child:  Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration:  const BoxDecoration(
                  color: CustomColors.limcardSecondary,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: CustomColors.blackPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 24),
                      ),
                       model.ninVerified ?
                      Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.greenPrimary,
                          ),
                          child: const Center(child: Icon(Icons.check, size: 14, color: Colors.white, ),)
                      )
                          :
                      GestureDetector(
                        onTap: onSelected,
                        child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomColors.limcadPrimary,
                            ),
                            child: const Center(child: Icon(Icons.add, size: 14, color: Colors.white, ),)
                        ),
                      )
                    ],).padding(left: 22, top: 20, right: 22),
                  SizedBox(
                    height: subtitle.isEmpty ? 11 : 50,
                    child: Text(subtitle,
                      style: const TextStyle(
                          color: CustomColors.blackPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ).padding(left: 22, top: 8, right: 22),
                  const SizedBox(height: 24,).hideIf(subtitle.isEmpty)
                ],
              ),
            ),
            const Row(children: [
              Icon(Icons.lock, color: Colors.white, size: 24,),
              Text(
                " Your personal details are fully protected",
                style: TextStyle(
                    color: CustomColors.kWhite,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              )
            ],).padding(top: 22, left: 20, right: 20)
          ],),
        )
      ],
    );
  }


}
