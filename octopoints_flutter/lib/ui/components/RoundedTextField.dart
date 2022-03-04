import 'package:flutter/material.dart';

import '../theme/OctopointsTheme.dart';

class RoundedTextField extends StatefulWidget {

  final TextEditingController controller;
  final String label;

  const RoundedTextField({required this.controller, required this.label});

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: TextField(
        controller: widget.controller,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
        onChanged: (value) => setState(() {
          widget.controller.text = value;
        }),
        autofocus: true,
        decoration: InputDecoration(
          hintText: widget.controller.text,
          errorText: widget.controller.text.isEmpty ? "Non può essere vuoto" : null,
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
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}