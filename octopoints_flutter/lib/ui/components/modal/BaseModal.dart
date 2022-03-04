import 'package:flutter/material.dart';

import '../../theme/OctopointsTheme.dart';

class BaseModal extends StatelessWidget {
  static Future<void> showModal(BuildContext context, Widget child,
      {EdgeInsetsGeometry? padding}) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => BaseModal._(child, padding),
      isScrollControlled: true,
      backgroundColor: OctopointsTheme.lightGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  final Widget child;
  EdgeInsetsGeometry? padding;

  BaseModal._(this.child, this.padding) {
    padding ??= const EdgeInsets.symmetric(vertical: 40, horizontal: 20);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: child,
    );
  }
}
