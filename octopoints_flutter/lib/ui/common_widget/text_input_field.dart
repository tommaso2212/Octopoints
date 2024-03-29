import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/theme/octopoints_theme.dart';

class TextInputField extends StatefulWidget {
  final String initialValue;
  final String label;
  final void Function(String) onChanged;
  final TextInputType textInputType;
  final bool autoFocus;
  late bool Function(String)? validateInput;
  TextEditingController? controller;

  TextInputField(
      {Key? key,
      required this.initialValue,
      required this.label,
      required this.onChanged,
      this.textInputType = TextInputType.text,
      this.autoFocus = true,
      this.validateInput,
      this.controller})
      : super(key: key) {
    validateInput ??= (value) => value.isNotEmpty;
  }

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late bool isValid;

  @override
  void initState() {
    widget.controller ??= TextEditingController();
    widget.controller!.text = widget.initialValue;
    isValid = widget.validateInput!(widget.initialValue);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextInputField oldWidget) {
    if (widget.validateInput != null && widget.controller != null) {
      isValid = widget.validateInput!(widget.controller!.text);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
      ),
      onChanged: (value) => setState(() {
        isValid = widget.validateInput!(value);
        widget.onChanged(value);
      }),
      autofocus: widget.autoFocus,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        errorText: isValid ? null : "Invalid value",
        label: Text(
          widget.label,
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
        filled: true,
        fillColor: OctopointsTheme.darkGrey,
      ),
    );
  }
}
