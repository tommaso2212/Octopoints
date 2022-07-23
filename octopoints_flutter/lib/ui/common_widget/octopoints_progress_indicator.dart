import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/theme/octopoints_theme.dart';

class OctopointsProgressIndicator extends StatelessWidget {
  const OctopointsProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: OctopointsTheme.primaryColor,
      ),
    );
  }
}