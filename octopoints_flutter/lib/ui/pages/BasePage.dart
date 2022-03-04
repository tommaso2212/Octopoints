import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/components/CreateFAB.dart';
import 'package:octopoints_flutter/ui/components/modal/BaseModal.dart';

class BasePage extends StatelessWidget {
  final Widget body;
  final AppBar appBar;
  final Widget createModal;

  BasePage({required this.appBar, required this.body, required this.createModal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: appBar,
          body: body,
          floatingActionButton: CreateFAB(
            onPressed: () => BaseModal.showModal(context, createModal),
          ),
        );
  }
}
