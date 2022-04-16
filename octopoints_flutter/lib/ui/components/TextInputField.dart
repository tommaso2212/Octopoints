import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/theme/OctopointsTheme.dart';

class TextInputField extends TextField {
  TextInputField({
    required TextEditingController controller,
    required String label,
    required Function onChanged,
    TextInputType textInputType = TextInputType.text,
    bool autoFocus = true,
  }) : super(
          textAlign: TextAlign.center,
          controller: controller,
          style: const TextStyle(
            color: Colors.white,
          ),
          onChanged: (_) => onChanged(),
          autofocus: autoFocus,
          keyboardType: textInputType,
          decoration: InputDecoration(
            hintText: controller.text,
            errorText: controller.text.isEmpty ? "Non può essere vuoto" : null,
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
            border: const OutlineInputBorder(),
          ),
        );
}
