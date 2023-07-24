import 'package:cookbook/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ToggleButtonsWidget extends StatefulWidget {
  final List<String> types;
  final VoidCallback? onPressed;

  const ToggleButtonsWidget({Key? key, required this.types, this.onPressed})
      : super(key: key);

  @override
  State<ToggleButtonsWidget> createState() => _ToggleButtonsWidgetState();
}

class _ToggleButtonsWidgetState extends State<ToggleButtonsWidget> {
  int _selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: List.generate(
          widget.types.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedButtonIndex = index;
                  widget.onPressed?.call();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedButtonIndex == index
                      ? AppColors.primaryColor
                      : AppColors.transparentColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Center(
                  child: Text(
                    widget.types[index],
                    style: TextStyle(
                      color: _selectedButtonIndex == index
                          ? AppColors.appWhiteColor
                          : AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
