import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/components/TextInputField.dart';
import 'package:octopoints_flutter/ui/components/modal/CreateModal.dart';
import 'package:octopoints_flutter/ui/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class CreateUserModal extends StatefulWidget {

  @override
  State<CreateUserModal> createState() => _CreateUserModalState();
}

class _CreateUserModalState extends State<CreateUserModal> {
  String username ="";

  void createUser(BuildContext context) {
    context.read<UserProvider>().createUser(
          username,
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CreateModal(
      title: 'Create user',
      formInputs: [
        TextInputField(
          initialValue: username,
          label: 'Username',
          onChanged: (value) => setState((){
            username = value;
          }),
        ),
      ],
      isValid: username.isNotEmpty,
      onConfirm: () => createUser(context),
    );
  }
}