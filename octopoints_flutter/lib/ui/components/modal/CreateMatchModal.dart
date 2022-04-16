import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/components/TextInputField.dart';
import 'package:octopoints_flutter/ui/components/modal/CreateModal.dart';
import 'package:octopoints_flutter/ui/providers/MatchProvider.dart';
import 'package:provider/provider.dart';

class CreateMatchModal extends StatefulWidget {
  @override
  _CreateMatchModalState createState() => _CreateMatchModalState();
}

class _CreateMatchModalState extends State<CreateMatchModal> {
  final TextEditingController _controller = TextEditingController();
  bool isValid = false;

  @override
  void initState() {
    super.initState();
  }

  void createMatch(BuildContext context) {
    context.read<MatchProvider>().createMatch(
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
      onConfirm: () => createMatch(context),
    );
  }
}
