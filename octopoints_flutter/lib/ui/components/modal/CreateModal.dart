import 'package:flutter/material.dart';
import '../../common_widget/confirm_button.dart';


class CreateModal extends StatelessWidget {
  
  final String title;
  final List<Widget> formInputs;
  final bool isValid;
  final Function onConfirm;

  const CreateModal({required this.title, required this.formInputs, required this.isValid, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ...formInputs,
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConfirmButton(
            onPressed: !isValid ? null : () => onConfirm(),
          ),
        ),
      ],
    );
  }
}
