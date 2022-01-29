import 'package:flutter/material.dart';
import 'package:octopoints/view/theme/OctopointsTheme.dart';

class ConfirmButton extends MaterialButton {
  ConfirmButton(void Function()? onPressed)
      : super(
          onPressed: onPressed,
          color: OctopointsTheme.primaryColor,
          disabledTextColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            'Conferma',
          ),
        );
}
