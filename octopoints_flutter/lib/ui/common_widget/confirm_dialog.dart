import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/common_widget/confirm_button.dart';
import 'package:octopoints_flutter/ui/theme/octopoints_theme.dart';

class ConfirmDialog {
  static Future<void> show(
      {required BuildContext context,
      required String title,
      Function()? onConfirm,
      Function()? onCancel}) {
    return showDialog<void>(
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
              onPressed: () {
                if(onCancel!= null){
                  onCancel();
                }
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: OctopointsTheme.textColor,
                  fontSize: 14,
                ),
              ),
            ),
            ConfirmButton(
              onPressed: () {
                if(onConfirm!= null){
                  onConfirm();
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
