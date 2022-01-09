import 'package:flutter/material.dart';
import 'package:octopoints/view/theme/OctopointsTheme.dart';
import 'package:octopoints/view/widget/common/ConfirmButton.dart';

class ConfirmDialog {
  static Future<bool?> show(BuildContext context, String title) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          backgroundColor: OctopointsTheme.lightGrey,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
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
      },
    );
  }
}
