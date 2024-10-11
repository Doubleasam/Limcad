import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

extension WidgetExtension on Widget {
  Widget padding(
      {double left = 0, double right = 0, double top = 0, double bottom = 0}) {
    return Padding(
        padding:
        EdgeInsets.only(bottom: bottom, top: top, left: left, right: right),
        child: this);
  }

  Widget paddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Widget paddingSymmetric({double vertical = 0, double horizontal = 0}) {
    return Padding(
        padding:
        EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this);
  }

  Widget addSpace({double x = 0, double y = 0}) {
    return SizedBox(width: x, height: y);
  }

  Widget replace(Widget widget, bool when) {
    return when ? widget : this;
  }

  Widget hideIf(bool when) {
    return when ? const SizedBox() : this;
  }

  Widget center() {
    return Center(child: this);
  }

  Widget greyOut([bool greyOut = true]) {
    return greyOut ?
    AbsorbPointer(
      child: Opacity(
        opacity: 0.5,
        child: this,
      ),
    ):this;
  }

}

extension CustomInputDecoration on InputDecoration {
  InputDecoration dropDownDecoration() {
    return copyWith(
        contentPadding: const EdgeInsets.only(left: 12),
        prefixIcon: const SizedBox(),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 1.5, color: Color(0xffEBE8E8))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 1.5, color: Color(0xffEBE8E8))),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 1.5, color: Color(0xffEBE8E8))),
        labelText: "What are you paying for?");
  }
}

extension StringExtension on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String hideMiddleCharacters({int numOfHiddenCharacters = 0}) {
    if (numOfHiddenCharacters <= 0) {
      return this; // Return the original string if the number of characters to hide is non-positive
    }

    if (length < numOfHiddenCharacters) {
      return this; // Return the original string if there aren't enough characters to hide
    }

    final int middleStartIndex = (length - numOfHiddenCharacters) ~/ 2;
    final int middleEndIndex = middleStartIndex + numOfHiddenCharacters;

    final String prefix = substring(0, middleStartIndex);
    final String suffix = substring(middleEndIndex);

    return '$prefix${'*' * numOfHiddenCharacters}$suffix';
  }

  String hideEndCharacters({int numOfHiddenCharacters = 0}) {
    if (numOfHiddenCharacters <= 0) {
      return this; // Return the original string if the number of characters to hide is non-positive
    }

    if (length < numOfHiddenCharacters) {
      return this; // Return the original string if there aren't enough characters to hide
    }

    final int startIndex = length - numOfHiddenCharacters;
    final String prefix = substring(0, startIndex);
    final String suffix = substring(startIndex);

    return '$prefix${'*' * numOfHiddenCharacters}';
  }

  String addSpacingAfterElements({int numOfElements = 0}) {
    if (numOfElements <= 0 || numOfElements >= length) {
      return this; // Return the original string if the number of elements is invalid
    }

    final List<String> elements = split('');

    for (int i = numOfElements; i < elements.length; i += numOfElements + 1) {
      elements.insert(i, " ");
    }

    return elements.join();
  }
}
