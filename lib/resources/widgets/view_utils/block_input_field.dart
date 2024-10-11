import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:sms_autofill/sms_autofill.dart';

class BlockInputField extends StatefulWidget {
  final int digitCount;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onSaved;
  final Function(String?)? onCodeChange;
  final Function? onChange;
  final Color? textColor;
  final bool obscureText;
  final FocusNode? node;

  const BlockInputField({
    super.key,
    required this.digitCount,
    required this.controller,
    this.validator,
    this.onSaved,
    this.onChange,
    this.onCodeChange,
    this.textColor = CustomColors.primary0_5,
    this.obscureText = false,
    this.node,
  });

  @override
  BlockInputFieldState createState() => BlockInputFieldState();
}

class BlockInputFieldState extends State<BlockInputField> {
  SmsAutoFill? smsAutoFill;

  @override
  void initState() {
    super.initState();
    _smsListener();
  }

  void _smsListener() async {
    smsAutoFill = SmsAutoFill();
    await smsAutoFill?.getAppSignature;
    await smsAutoFill?.listenForCode();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350, maxHeight: 50),
        child: Pinput(

            obscureText: widget.obscureText,
            obscuringCharacter: "*",
            defaultPinTheme: PinTheme(
              width: 50,
              height: 60,
              textStyle: TextStyle(color: CustomColors.primary0_5, fontSize: 20),
              decoration: BoxDecoration(
                  color:Colors.transparent,
                  border: Border.all(color: CustomColors.neutral5, width: 1),
                  borderRadius: BorderRadius.circular(10)
              ),),
            cursor: Container(color: CustomColors.primary0_5, width: 2, height: 24,),
            focusNode: widget.node,
            controller: widget.controller,
            length: widget.digitCount,
            autofocus: true,
            onChanged: widget.onCodeChange,
            androidSmsAutofillMethod:  AndroidSmsAutofillMethod.smsRetrieverApi
        )
    );
  }
}
