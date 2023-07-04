import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.label,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.readOnly,
    this.nextFocusNode,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final FocusNode? focusNode;
  final IconData? prefixIcon, suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final FocusNode? nextFocusNode;
  final Function(String)? onChanged;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: widget.readOnly ?? false,
      onChanged: widget.onChanged ?? (value) {},
      style: const TextStyle(fontSize: 18),
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      onFieldSubmitted: (value) => widget.nextFocusNode?.requestFocus(),
      validator: widget.validator ?? (value) => null,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        // how to check if the theme is dark or light

        fillColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.appDarkGreyColor
            : AppColors.appGreyColor.withOpacity(0.5),
        filled: true,
        hintText: widget.label ?? "",
        prefixIcon: Icon(
          widget.prefixIcon,
          size: 28,
          color: AppColors.primaryColor,
        ),
        suffixIcon: Icon(
          widget.suffixIcon,
          size: 28,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
