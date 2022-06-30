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
  String matchName = "";

  void createMatch(BuildContext context) {
    context.read<MatchProvider>().createMatch(
          matchName
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CreateModal(
      title: 'Nuova partita',
      formInputs: [
        TextInputField(
          initialValue: matchName,
          label: 'Nome Partita',
          onChanged: (value) => setState((){
            matchName = value;
          }),
        ),
      ],
      isValid: matchName.isNotEmpty,
      onConfirm: () => createMatch(context),
    );
  }
}
