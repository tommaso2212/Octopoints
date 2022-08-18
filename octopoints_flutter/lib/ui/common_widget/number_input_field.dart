import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/common_widget/text_input_field.dart';
import 'package:octopoints_flutter/ui/theme/octopoints_theme.dart';

class NumberInputField extends StatefulWidget {
  final String initialValue;
  final String label;
  final Function(String) onChanged;
  late bool Function(String)? validateInput;

  NumberInputField({
    Key? key,
    required this.initialValue,
    required this.label,
    required this.onChanged,
    this.validateInput,
  }) : super(key: key) {
    validateInput ??= (value) => value.isNotEmpty;
  }

  @override
  State<NumberInputField> createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (widget.validateInput!(controller.text)) {
              controller.text = (int.parse(controller.text) - 1).toString();
            } else {
              controller.text = "-1";
            }
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
            widget.onChanged(controller.text);
          },
          icon: const Icon(
            Icons.remove,
            size: 40,
            color: OctopointsTheme.primaryColor,
          ),
          padding: const EdgeInsets.only(
            right: 5,
          ),
        ),
        Expanded(
          child: TextInputField(
            initialValue: controller.text,
            controller: controller,
            label: widget.label,
            textInputType: const TextInputType.numberWithOptions(signed: true),
            autoFocus: false,
            validateInput: widget.validateInput != null
                ? (value) => widget.validateInput!(value)
                : null,
            onChanged: (value) => widget.onChanged(value),
          ),
        ),
        IconButton(
          onPressed: () {
            if (widget.validateInput!(controller.text)) {
              controller.text = (int.parse(controller.text) + 1).toString();
            } else {
              controller.text = "1";
            }
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
            widget.onChanged(controller.text);
          },
          icon: const Icon(
            Icons.add,
            size: 40,
            color: OctopointsTheme.primaryColor,
          ),
          padding: const EdgeInsets.only(
            left: 5,
          ),
        ),
      ],
    );
  }
}
