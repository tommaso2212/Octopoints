import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/common_widget/text_input_field.dart';
import 'package:octopoints_flutter/ui/modal/create_modal.dart';
import 'package:octopoints_flutter/ui/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CreateUserModal extends StatefulWidget {
  @override
  State<CreateUserModal> createState() => _CreateUserModalState();
}

class _CreateUserModalState extends State<CreateUserModal> {
  String username = "";

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
          onChanged: (value) => setState(() {
            username = value;
          }),
        ),
      ],
      isValid: username.isNotEmpty,
      onConfirm: () => createUser(context),
    );
  }
}
