import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limcad/resources/utils/custom_colors.dart';
import 'package:limcad/resources/utils/extensions/widget_extension.dart';

class CustomTextFields extends StatefulWidget {
  final Color iconColor;
  final String? icon;
  final bool iconPresent;
  final TextEditingController? controller;
  final String? labelText;
  final String? label;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final int? inputLimit;
  final InputFormatter? formatter;
  final bool autocorrect;
  final Function? validate;
  final Function? onSave;
  final Function? onchange;
  final Function? onTap;
  final Function? onEditingComplete;
  final FocusNode? node;
  final bool showSuffixBusy;
  final bool readOnly;
  final bool showLabel;
  final int? maxLines;
  final String hintText;
  final AutovalidateMode? autovalidateMode;
  final int? maxText;
  final Function(String)? onFieldSubmitted;
  final bool disabled;
  final Widget? suffixWidget;
  final TextInputAction? textInputAction;
  final Color? textBackgroundColor;

  const CustomTextFields({
    Key? key,
    this.iconColor = CustomColors.limcadPrimary,
    this.controller,
    this.labelText = "",
    this.label,
    this.keyboardType,
    this.textCapitalization,
    this.inputLimit,
    this.formatter,
    this.autocorrect = false,
    this.validate,
    this.onSave,
    this.onchange,
    this.onTap,
    this.onEditingComplete,
    this.node,
    this.showSuffixBusy = false,
    this.readOnly = false,
    this.showLabel = false,
    this.maxLines,
    this.iconPresent = false,
    this.icon,
    this.hintText = "",
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onFieldSubmitted,
    this.maxText,
    this.disabled = false,
    this.suffixWidget,
    this.textInputAction,
    this.textBackgroundColor,
  }) : super(key: key);

  @override
  State<CustomTextFields> createState() => _CustomInputfieldsFieldState();
}

class _CustomInputfieldsFieldState extends State<CustomTextFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style: Theme.of(context).textTheme.bodyMedium!,
        ).padding(bottom: 6).hideIf(!widget.showLabel),
        TextFormField(
          decoration: InputDecoration(
              fillColor: widget.controller?.text.isEmpty == true
                  ? widget.textBackgroundColor ?? Colors.white
                  : widget.textBackgroundColor ?? Colors.transparent,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey[400]),
              contentPadding: EdgeInsets.only(left: 27),

              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      width: 1.0, color: CustomColors.limcardFaded)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      width: 1.0, color: CustomColors.limcardFaded)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      width: 1.0, color: CustomColors.limcardFaded)),
              labelText: widget.labelText,
              suffixIcon: const CupertinoActivityIndicator()
                  .hideIf(!widget.showSuffixBusy)),
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
          controller: widget.controller,
          readOnly: widget.readOnly,
          autocorrect: widget.autocorrect,
          focusNode: widget.node,
          maxLength: widget.maxText,
          onFieldSubmitted: widget.onFieldSubmitted,
          autovalidateMode: widget.autovalidateMode,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization ??
              (widget.keyboardType != TextInputType.emailAddress
                  ? TextCapitalization.sentences
                  : TextCapitalization.none),
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.inputLimit),
            if (widget.formatter == InputFormatter.stringOnly)
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z-]")),
            if (widget.formatter == InputFormatter.digitOnly)
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            if (widget.formatter == InputFormatter.alphaNumericOnly)
              FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
          ],
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          validator: (value) =>
              widget.validate != null ? widget.validate!(value) : null,
          onSaved: (value) =>
              widget.onSave != null ? widget.onSave!(value) : null,
          onChanged: (value) =>
              widget.onchange != null ? widget.onchange!(value) : null,
          onTap: () => widget.onTap != null ? widget.onTap!() : null,
          onEditingComplete: () => widget.onEditingComplete != null
              ? widget.onEditingComplete!()
              : null,
        ),
      ],
    );
  }
}

enum InputFormatter { stringOnly, digitOnly, alphaNumericOnly }

class CustomTextArea extends StatefulWidget {
  final Color iconColor;
  final Icon? icon;
  final bool iconPresent;
  final TextEditingController? controller;
  final String? labelText;
  final String? label;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final int? inputLimit;
  final InputFormatter? formatter;
  final bool autocorrect;
  final Function? validate;
  final Function? onSave;
  final Function? onchange;
  final Function? onTap;
  final Function? onEditingComplete;
  final FocusNode? node;
  final bool showSuffixBusy;
  final bool readOnly;
  final bool showLabel;
  final int? maxLines;
  final String hintText;
  final AutovalidateMode? autovalidateMode;
  final int? maxText;
  final Function(String)? onFieldSubmitted;
  final bool disabled;
  final Widget? suffixWidget;
  final TextInputAction? textInputAction;

  const CustomTextArea({
    Key? key,
    this.iconColor = CustomColors.limcadPrimary,
    this.controller,
    this.labelText = "",
    this.label,
    this.keyboardType,
    this.textCapitalization,
    this.inputLimit,
    this.formatter,
    this.autocorrect = false,
    this.validate,
    this.onSave,
    this.onchange,
    this.onTap,
    this.onEditingComplete,
    this.node,
    this.showSuffixBusy = false,
    this.readOnly = false,
    this.showLabel = false,
    this.maxLines,
    this.iconPresent = false,
    this.icon,
    this.hintText = "",
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onFieldSubmitted,
    this.maxText,
    this.disabled = false,
    this.suffixWidget,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<CustomTextArea> createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style: Theme.of(context).textTheme.bodyMedium!,
        ).padding(bottom: 6).hideIf(!widget.showLabel),
        TextFormField(
          decoration: InputDecoration(
              fillColor: widget.controller?.text.isEmpty == true
                  ? Colors.white
                  : Colors.white,
              hintText: widget.hintText,
              prefixIcon: widget.icon,
              hintStyle:
                  TextStyle(color: CustomColors.smallTextGrey.withOpacity(0.5)),
              contentPadding: EdgeInsets.only(left: 16, top: 16),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 1.0,
                      color: CustomColors.smallTextGrey.withOpacity(0.5))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 1.0,
                      color: CustomColors.smallTextGrey.withOpacity(0.5))),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 1.0,
                      color: CustomColors.smallTextGrey.withOpacity(0.5))),
              labelText: widget.labelText,
              suffixIcon: const CupertinoActivityIndicator()
                  .hideIf(!widget.showSuffixBusy)),
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
          controller: widget.controller,
          readOnly: widget.readOnly,
          autocorrect: widget.autocorrect,
          focusNode: widget.node,
          maxLength: widget.maxText,
          onFieldSubmitted: widget.onFieldSubmitted,
          autovalidateMode: widget.autovalidateMode,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization ??
              (widget.keyboardType != TextInputType.emailAddress
                  ? TextCapitalization.sentences
                  : TextCapitalization.none),
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.inputLimit),
            if (widget.formatter == InputFormatter.stringOnly)
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z-]")),
            if (widget.formatter == InputFormatter.digitOnly)
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            if (widget.formatter == InputFormatter.alphaNumericOnly)
              FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
          ],
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          validator: (value) =>
              widget.validate != null ? widget.validate!(value) : null,
          onSaved: (value) =>
              widget.onSave != null ? widget.onSave!(value) : null,
          onChanged: (value) =>
              widget.onchange != null ? widget.onchange!(value) : null,
          onTap: () => widget.onTap != null ? widget.onTap!() : null,
          onEditingComplete: () => widget.onEditingComplete != null
              ? widget.onEditingComplete!()
              : null,
        ),
      ],
    );
  }
}


class DateInputWidget extends StatelessWidget {
  final String? label;
  final String hint;
  final TextEditingController controller;
  final Function? validator;
  final Function? onTap;
  final String? title;
  final Widget? suffix;
  final Widget? leading;

  const DateInputWidget({
    Key? key,
    this.label,
    this.validator,
    this.onTap,
    required this.hint,
    required this.controller,
    this.title = '',
    this.suffix,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: TextStyle(
              color: CustomColors.blackPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w300),
        ).padding(bottom: 8).hideIf(title!.isEmpty),
        GestureDetector(
          onTap: onTap as void Function()?,
          child: AbsorbPointer(
            child: TextFormField(
              style: const TextStyle(
                  fontWeight: FontWeight.w300, fontSize: 14, color: CustomColors.blackPrimary),
              controller: controller,
              validator: (value) => validator != null ? validator!(value) : null,
              decoration: InputDecoration(
                  fillColor: controller.text.isEmpty == true
                      ? Colors.white
                      : Colors.white,
                  hintText: hint,
                  prefixIcon: leading,
                  hintStyle:
                  TextStyle(color: CustomColors.blackPrimary),
                  contentPadding: EdgeInsets.only(left: 16, top: 16),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: 1.0,
                          color: CustomColors.smallTextGrey.withOpacity(0.5))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: 1.0,
                          color: CustomColors.smallTextGrey.withOpacity(0.5))),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          width: 1.0,
                          color: CustomColors.smallTextGrey.withOpacity(0.5))),
                  labelText: label,
              ),
            ),
          ),
        ),
      ],
    );
  }
}