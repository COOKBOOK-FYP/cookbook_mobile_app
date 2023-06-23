import 'package:cookbook/constants/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobileNumberTextField extends StatefulWidget {
  const MobileNumberTextField({
    Key? key,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<MobileNumberTextField> createState() => _MobileNumberTextFieldState();
}

class _MobileNumberTextFieldState extends State<MobileNumberTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(fontSize: 18),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(
            r'^\+\d{12}$',
          ),
        ),
        LengthLimitingTextInputFormatter(13),
      ],
      validator: widget.validator ?? (value) => null,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        fillColor: AppColors.appGreyColor,
        filled: true,
        hintText: "Enter Mobile Number",
        border: InputBorder.none,
        prefixIcon: CountryCodePicker(
          initialSelection: 'PK',
          showCountryOnly: true,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          showOnlyCountryWhenClosed: true,
          alignLeft: false,
          hideMainText: true,
          onInit: (value) {
            widget.controller.text = value!.dialCode.toString();
          },
          onChanged: (value) =>
              widget.controller.text = value.dialCode.toString(),
        ),
      ),
    );
  }
}
