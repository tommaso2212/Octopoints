import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/theme/OctopointsTheme.dart';

class OctopointsProgressIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 35,
      child: CircularProgressIndicator(
        color: OctopointsTheme.primaryColor,
      ),
    );
  }
}