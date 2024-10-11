import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:limcad/features/laundry/model/laundry_vm.dart';
import 'package:limcad/resources/utils/assets/asset_util.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/default_scafold.dart';
import 'package:stacked/stacked.dart';

class FileUploadScreen extends StatefulWidget {
  static String tag = '/fileUpload';

  @override
  FileUploadScreenScreenState createState() => FileUploadScreenScreenState();
}

class FileUploadScreenScreenState extends State<FileUploadScreen> {
  late LaundryVM model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LaundryVM(),
      onViewModelReady: (model) {
        this.model = model;
        model.context = context;
        model.init(context, LaundryOption.image, null);
      },
      builder: (context, model, child) => DefaultScaffold2(
        showAppBar: true,
        includeAppBarBackButton: true,
        title: "Upload File",
        backgroundColor: CustomColors.backgroundColor,
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: DottedBorder(
              dashPattern: [4, 8],
              strokeWidth: 4,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AssetUtil.upload,
                      width: 82,
                      height: 82,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Drag and drop file here',
                      style: TextStyle(color: Colors.blue),
                    ),
                    const SizedBox(height: 16),
                    const Text('OR',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await model.pickFileFromGallery();
                        if (model.selectedFile != null) {
                          // Handle the selected file
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'File selected: ${model.selectedFile!.name}')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Browse file'),
                    ),
                    if (model.selectedFile != null)
                      Column(
                        children: [
                          SizedBox(height: 16),
                          Text('Selected File: ${model.selectedFile!.name}'),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ).paddingSymmetric(vertical: 16, horizontal: 16),
      ),
    );
  }
}
