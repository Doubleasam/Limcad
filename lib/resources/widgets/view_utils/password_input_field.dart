import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';
import 'package:limcad/resources/widgets/view_utils/custom_text_field.dart';


class PasswordInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final TextInputType keyboardType;
  final int? inputLimit;
  final Function? validate;
  final Function? onSave;
  final Function? onChange;
  final InputFormatter? formatter;
  final TextAlign textAlign;
  final FocusNode? node;
  final AutovalidateMode? autovalidateMode;

  const PasswordInputField(
      {Key? key,
        this.controller,
        this.labelText = "Enter password",
        required this.keyboardType,
        this.inputLimit,
        this.validate,
        this.onSave,
        this.onChange,
        this.formatter,
        this.textAlign = TextAlign.start,
        this.node,
        this.autovalidateMode = AutovalidateMode.disabled})
      : super(key: key);

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: Theme.of(context).textTheme.bodyMedium!,
          ).padding(bottom: 6),

          TextFormField(
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),

          readOnly: false,
          // textAlignVertical: TextAlignVertical.top,
          // style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          controller: widget.controller,

          focusNode: widget.node,
          autovalidateMode: widget.autovalidateMode,
          decoration: InputDecoration(
            fillColor: widget.controller?.text.isEmpty == true
                ? Colors.white
                : Colors.transparent,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(width: 1.0, color: CustomColors.limcardFaded)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(width: 1.0, color: CustomColors.limcardFaded)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(width: 1.0, color: CustomColors.limcardFaded)),
            errorMaxLines: 5,
            // errorStyle: const TextStyle(),

            contentPadding: EdgeInsets.zero,
            prefixText: "|     ",
            prefixStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xffEBE8E8),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: CustomColors.labelColor,
              ),
              onPressed: () => obscureText(!_passwordVisible),
            ),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.inputLimit),
            if (widget.formatter == InputFormatter.digitOnly)
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
          ],
          keyboardType: widget.keyboardType,
          obscureText: !_passwordVisible,
          //obscuringCharacter: "⚫",

          validator: (value) =>
          widget.validate != null ? widget.validate!(value) : null,
          onSaved: (value) => widget.onSave != null ? widget.onSave!(value) : null,
          onChanged: (value) =>
          widget.onChange != null ? widget.onChange!(value) : null,
    ),

        ],
      );
  }

  void obscureText(bool value) {
    setState(() {
      _passwordVisible = value;
    });
  }
}
