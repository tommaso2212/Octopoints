import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/theme/OctopointsTheme.dart';

class TextInputField extends StatelessWidget {

  final TextEditingController controller;
  final String label;
  final Function onChanged;
  final TextInputType textInputType;
  final bool autoFocus;
  late bool Function(String)? validateInput;

  TextInputField ({
    required this.controller,
    required this.label,
    required this.onChanged,
    this.textInputType = TextInputType.text,
    this.autoFocus = true,
    this.validateInput,
  }){
    validateInput ??= (value) => value.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
          controller: controller,
          style: const TextStyle(
            color: Colors.white,
          ),
          onChanged: (value) => validateInput!(value)? onChanged() : null,
          autofocus: autoFocus,
          keyboardType: textInputType,
          decoration: InputDecoration(
            hintText: controller.text,
            errorText: validateInput!(controller.text) ? null : "Invalid value",
            label: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: OctopointsTheme.primaryColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: OctopointsTheme.lightGrey),
            ),
          ),
    );
  }
}