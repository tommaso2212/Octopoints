import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/components/ConfirmButton.dart';

import '../theme/OctopointsTheme.dart';

class ConfirmDialog {
  static Future<bool?> show(BuildContext context, String title) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            backgroundColor: OctopointsTheme.lightGrey,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'Annulla',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              ConfirmButton(
                () => Navigator.pop(context, true),
              ),
            ],
          );
        });
  }
}
