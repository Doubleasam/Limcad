import 'package:camera/camera.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:limcad/features/auth/models/signup_request.dart';
import 'package:limcad/features/auth/models/signup_vm.dart';
import 'package:limcad/features/dashboard/model/laundry_model.dart';
import 'package:limcad/features/laundry/model/laundry_service_response.dart';
import 'package:limcad/features/laundry/model/laundry_vm.dart';
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

class SelectClothesPage extends StatefulWidget {
  static const String routeName = "/SelectClothesPage";

  final LaundryItem? laundry;

  const SelectClothesPage({Key? key, this.laundry}) : super(key: key);

  @override
  State<SelectClothesPage> createState() => _SelectClothesPageState();
}

class _SelectClothesPageState extends State<SelectClothesPage> {
  late LaundryVM model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LaundryVM>.reactive(
      viewModelBuilder: () => LaundryVM(),
      onViewModelReady: (model) {
        this.model = model;
        model.context = context;
        model.init(context, LaundryOption.selectClothe, widget.laundry);
      },
      builder: (BuildContext context, model, child) => DefaultScaffold2(
        showAppBar: true,
        includeAppBarBackButton: true,
        title: widget.laundry?.name ?? "",
        backgroundColor: CustomColors.backgroundColor,
        busy: model.loading,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select cloths type(s) and quantity(ies)",
                style: Theme.of(context).textTheme.bodyMedium!.merge(
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                textAlign: TextAlign.center,
              ).padding(bottom: 24),
              Container(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: gray.withOpacity(0.5), width: 0.5),
                  color: Colors.white,
                ),
                child: clothesView(model.isPreview),
              ),
              16.height,
              DateInputWidget(
                title: "Pickup Date",
                hint: "Select your preferred pickup date",
                controller: model.pickupDateController,
                suffix: Icon(CupertinoIcons.chevron_down,
                  size: 20,
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                     model.pickupDate = formattedDate;
                     setState(() {
                       model.pickupDateController.text = formattedDate;
                     });

                  }
                },
              ).padding(bottom: 20),
              // CustomTextArea(
              //   controller: model.instructionController,
              //   keyboardType: TextInputType.name,
              //   label: "Instruction (Optional)",
              //   showLabel: true,
              //   formatter: InputFormatter.stringOnly,
              //   maxLines: 5,
              //   autocorrect: false,
              //   onSave: (value) => model.instructionController.text = value,
              // ).padding(bottom: 20).hideIf(model.isPreview),
              ElevatedButton(
                onPressed:  model.laundryServiceItems!.isEmpty || model.selectedItems.isEmpty || model.pickupDateController.text.isEmpty ? null :
                () {
                  FocusScope.of(context).unfocus();
               model.isPreview ? model.proceedToPay() :   model.proceed();
                },
                child: Text(
                  model.isPreview ? "Proceed to payment" : "Preview order",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              // 16.height.hideIf(!model.isPreview),
              // OutlinedButton(
              //   onPressed: () {
              //     model.proceedToPay();
              //   },
              //   child: Text(
              //     "Pay on delivery",
              //     style: const TextStyle(
              //         fontSize: 16, fontWeight: FontWeight.w500),
              //   ),
              // ).hideIf(!model.isPreview),
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget clothesView(bool showPreview) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListView.builder(
          itemCount: model.laundryServiceItems?.length ?? 0,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            LaundryServiceItem? clothe = model.laundryServiceItems?[index];
            num quantity = model.selectedItems[clothe] ?? 0;

            return GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                    height: 60,
                    child: ListTile(
                      leading: commonCachedNetworkImage(
                        "assets/images/summer.png",
                        height: 32,
                        width: 32,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        clothe?.itemName ?? "",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(clothe?.itemDescription ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400)),
                      trailing: showPreview
                          ? Text(
                              clothe?.price.toString() ?? "",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            )
                          : Container(
                              width: 80,
                              child: InputQty(
                                maxVal: 100,
                                initVal: quantity,
                                steps: 1,
                                minVal: 0,
                                decimalPlaces: 0,
                                qtyFormProps: QtyFormProps(enableTyping: false),
                                decoration: QtyDecorationProps(
                                  btnColor: black,
                                  isBordered: false,
                                  minusBtn: Icon(Icons.remove),
                                  plusBtn: Icon(Icons.add),
                                ),
                                onQtyChanged: (val) {
                                  model.updateSelectedItem(clothe!, val);
                                },
                              ),
                            ),
                    ),
                  ),
                  const Divider().paddingSymmetric(horizontal: 16),
                ],
              ),
            );
          },
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              "N${model.calculateTotalPrice()}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        )
            .padding(top: 32, bottom: 32, left: 16, right: 16)
            .hideIf(!showPreview),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Instruction",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            8.height,
            const Text(
              "Please, don’t use detergent and brush on the jeans.",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ).padding(left: 16, right: 16, bottom: 18).hideIf(!showPreview),
      ],
    );
  }
}

class Clothe {
  String? image;
  String? profileImage;
  String? title;
  String? subtitle;
  String? details;
  String? categoryIcon;
  Color? color;
  double? price;
  int? srno;
  int? like;
  bool isSelected;

  Clothe({
    this.image,
    this.profileImage,
    this.title,
    this.subtitle,
    this.details,
    this.categoryIcon,
    this.color,
    this.price,
    this.srno,
    this.like,
    this.isSelected = false,
  });
}

List<Clothe> getClothes() {
  List<Clothe> list = [];

  list.add(Clothe(
      title: 'Shirts',
      image: AssetUtil.suitIcon,
      subtitle: "N100/pcs",
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(Clothe(
      title: 'Gown',
      image: AssetUtil.summerIcon,
      subtitle: "N100/pcs",
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(Clothe(
      title: 'Suit',
      image: AssetUtil.suitIcon,
      subtitle: "N100/pcs",
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(Clothe(
      title: 'Jeans',
      image: AssetUtil.summerIcon,
      subtitle: "N100/pcs",
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(Clothe(
      title: 'Jeans',
      image: AssetUtil.suitIcon,
      subtitle: "N100/pcs",
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(Clothe(
      title: 'Jeans',
      image: AssetUtil.summerIcon,
      subtitle: "N100/pcs",
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(Clothe(
      title: 'Sports',
      image: AssetUtil.suitIcon,
      subtitle: "N100/pcs",
      categoryIcon: 'assets/images/placeholder.jpg'));
  list.add(Clothe(
      title: 'Utility',
      image: AssetUtil.summerIcon,
      subtitle: "N100/pcs",
      categoryIcon: 'assets/images/placeholder.jpg'));

  return list;
}

const image1 = 'https://i.imgur.com/OB0y6MR.jpg'; //Landscape image
const image2 = 'https://i.imgur.com/CzXTtJV.jpg'; //Landscape image
const image3 =
    'https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpg'; //Landscape image
const image4 =
    'https://farm9.staticflickr.com/8505/8441256181_4e98d8bff5_z_d.jpg'; // Landscape image
const image5 = 'https://picsum.photos/id/237/200/300'; //potrait image
const image6 = 'https://picsum.photos/seed/picsum/200/300'; // potrait image
const image7 = 'https://picsum.photos/200/300';
const image8 = 'https://picsum.photos/200/300/?blur=2';
const image9 = 'https://picsum.photos/200/300?grayscale';
const image10 = 'https://picsum.photos/id/870/200/300?grayscale&blur=2';
