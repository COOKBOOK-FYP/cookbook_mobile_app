import 'package:cookbook/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

class DropDownWidget extends StatelessWidget {
  final Function(String?) onChanged;
  final String value;
  final List<String> items;
  const DropDownWidget(
      {Key? key,
      required this.onChanged,
      required this.value,
      required this.items})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: value,
        icon: const Icon(Ionicons.chevron_down),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.grey,
        ),
        onChanged: onChanged,
        items: items
            .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                value: value,
                child: value.text.fontFamily(AppFonts.robotoMonoMedium).make(),
              ),
            )
            .toList());
  }
}
