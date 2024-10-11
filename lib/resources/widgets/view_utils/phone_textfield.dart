import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';

class PhoneTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final String? label;
  final bool hideCountryCode;
  final bool showLabel;
  final Function? validate;
  final Function(String?)? onSave;
  final Function(String)? onChanged;
  final bool readOnly;
  final FocusNode? node;

  const PhoneTextField(
      {Key? key,
        this.controller,
        this.labelText = "",
        this.label = "",
        this.hintText = '',
        this.hideCountryCode = false,
        this.validate,
        this.showLabel = false,
        this.onSave,
        this.onChanged,
        this.readOnly = false,
        this.node})
      : super(key: key);

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.label!,
          style: Theme.of(context).textTheme.bodyMedium!,
        ).padding(bottom: 6).hideIf(!widget.showLabel),
        TextFormField(
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
          controller: widget.controller,
          readOnly: widget.readOnly,
          focusNode: widget.node,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          decoration: InputDecoration(
            // filled: true,
            fillColor: widget.controller?.text.isEmpty == true
                ? Colors.white
                : Colors.transparent,
            contentPadding: EdgeInsets.only(left: 27),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(width: 1.0, color: CustomColors.limcardFaded)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(width: 1.0, color: CustomColors.limcardFaded)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(width: 1.0, color: CustomColors.limcardFaded)),
            labelText: widget.labelText,
            hintText: widget.hintText,
          ),
          validator: (value) =>
          widget.validate != null ? widget.validate!(value) : null,
          onSaved: (value) => widget.onSave != null ? widget.onSave!(value) : null,
          onChanged: (value) =>
          widget.onChanged != null ? widget.onChanged!(value) : null,
        ),
      ],
    );
  }
}
