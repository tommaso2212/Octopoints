import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/theme/OctopointsTheme.dart';

class OctopointsProgressIndicator extends CircularProgressIndicator{
  const OctopointsProgressIndicator() : super(
    color: OctopointsTheme.primaryColor,
  );
}