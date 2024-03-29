import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/common_widget/confirm_button.dart';

class CreateModal extends StatelessWidget {
  final String title;
  final List<Widget> formInputs;
  final bool isValid;
  final Function onConfirm;

  const CreateModal({
    Key? key,
    required this.title,
    required this.formInputs,
    required this.isValid,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
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
            top: 10,
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
