import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/theme/octopoints_theme.dart';

class ConfirmButton extends StatelessWidget {
  final Function()? onPressed;

  const ConfirmButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: OctopointsTheme.primaryColor,
      disabledTextColor: OctopointsTheme.textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: const Text(
        'Confirm',
      ),
    );
  }
}
