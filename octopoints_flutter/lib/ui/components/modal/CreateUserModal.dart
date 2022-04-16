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
  final TextEditingController _controller = TextEditingController();
  bool isValid = false;

  @override
  void initState() {
    super.initState();
  }

  void createUser(BuildContext context) {
    context.read<UserProvider>().createUser(
          _controller.text,
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CreateModal(
      title: 'Nuova partita',
      formInputs: [
        TextInputField(
          controller: _controller,
          label: 'Nome Partita',
          onChanged: () => setState((){
            isValid = _controller.text.isNotEmpty;
          }),
        ),
      ],
      isValid: isValid,
      onConfirm: () => createUser(context),
    );
  }
}