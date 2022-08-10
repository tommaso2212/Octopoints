import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/common_widget/text_input_field.dart';
import 'package:octopoints_flutter/ui/modal/create_modal.dart';
import 'package:octopoints_flutter/ui/providers/match_provider.dart';
import 'package:provider/provider.dart';

class CreateMatchModal extends StatefulWidget {
  const CreateMatchModal({Key? key}) : super(key: key);

  @override
  _CreateMatchModalState createState() => _CreateMatchModalState();
}

class _CreateMatchModalState extends State<CreateMatchModal> {
  String matchName = "";

  void createMatch(BuildContext context) {
    context.read<MatchProvider>().createMatch(matchName);
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
          onChanged: (value) => setState(() {
            matchName = value;
          }),
        ),
      ],
      isValid: matchName.isNotEmpty,
      onConfirm: () => createMatch(context),
    );
  }
}
