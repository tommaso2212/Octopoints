import 'package:flutter/material.dart';
import 'package:octopoints/view/theme/OctopointsTheme.dart';

class CommonProgressIndicator extends CircularProgressIndicator {
  CommonProgressIndicator()
      : super(
          color: OctopointsTheme.primaryColor,
        );
}
