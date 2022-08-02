import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/common_widget/text_input_field.dart';
import 'package:octopoints_flutter/ui/theme/octopoints_theme.dart';

class PointsInputField extends StatefulWidget {
  final String initialValue;
  final String label;
  final Function(String) onChanged;

  const PointsInputField(
      {Key? key,
      required this.initialValue,
      required this.label,
      required this.onChanged})
      : super(key: key);

  @override
  State<PointsInputField> createState() => _PointsInputFieldState();
}

class _PointsInputFieldState extends State<PointsInputField> {
  TextEditingController controller = TextEditingController();
  late bool isValid;

  @override
  void initState() {
    controller.text = widget.initialValue;
    isValid = widget.initialValue.isNotEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          child: IconButton(
            onPressed: () {
              controller.text = (int.parse(controller.text) - 1).toString();
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              widget.onChanged(controller.text);
            },
            icon: const Icon(
              Icons.remove,
              size: 40,
              color: OctopointsTheme.primaryColor,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: 100,
          child: TextInputField(
            initialValue: controller.text,
            controller: controller,
            label: widget.label,
            textInputType: const TextInputType.numberWithOptions(signed: true),
            autoFocus: false,
            onChanged: (value) => widget.onChanged(value),
          ),
        ),
        IconButton(
          onPressed: () {
            controller.text = (int.parse(controller.text) + 1).toString();
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length));
            widget.onChanged(controller.text);
          },
          icon: const Icon(
            Icons.add,
            size: 40,
            color: OctopointsTheme.primaryColor,
          ),
          padding: const EdgeInsets.only(bottom: 60),
        ),
      ],
    );
  }
}
