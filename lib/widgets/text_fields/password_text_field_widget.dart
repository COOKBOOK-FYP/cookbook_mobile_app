import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  const PasswordTextFieldWidget({
    Key? key,
    required this.controller,
    this.label,
    this.focusNode,
    this.prefixIcon,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.nextFocusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final IconData? prefixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      // focusNode: widget.focusNode ?? FocusNode(),
      style: const TextStyle(fontSize: 18),
      obscureText: obscureText,
      onFieldSubmitted: (value) {
        widget.nextFocusNode?.requestFocus();
      },
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
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
        fillColor: context.isDarkMode
            ? AppColors.appDarkGreyColor
            : AppColors.appGreyColor.withOpacity(0.5),
        filled: true,
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: widget.label ?? "Password",
        prefixIcon: Icon(
          widget.prefixIcon ?? Icons.lock_outline,
          color: AppColors.primaryColor,
          size: 28,
        ),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primaryColor),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        ),
        border: InputBorder.none,
      ),
    );
  }
}
