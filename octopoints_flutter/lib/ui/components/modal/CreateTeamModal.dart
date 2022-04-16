import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/components/TextInputField.dart';
import 'package:octopoints_flutter/ui/components/modal/CreateModal.dart';
import 'package:octopoints_flutter/ui/providers/TeamProvider.dart';
import 'package:provider/provider.dart';

class CreateTeamModal extends StatefulWidget {

  @override
  State<CreateTeamModal> createState() => _CreateTeamModalState();
}

class _CreateTeamModalState extends State<CreateTeamModal> {
  final TextEditingController _controller = TextEditingController();
  bool isValid = false;

  @override
  void initState() {
    super.initState();
  }

  void createTeam(BuildContext context) {
    context.read<TeamProvider>().createTeam(
          _controller.text,
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CreateModal(
      title: 'Nuova squadra',
      formInputs: [
        TextInputField(
          controller: _controller,
          label: 'Nome squadra',
          onChanged: () => setState((){
            isValid = _controller.text.isNotEmpty;
          }),
        ),
      ],
      isValid: isValid,
      onConfirm: () => createTeam(context),
    );
  }
}