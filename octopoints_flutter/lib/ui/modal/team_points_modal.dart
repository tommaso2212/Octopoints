import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/team.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/common_widget/number_input_field.dart';
import 'package:octopoints_flutter/ui/providers/team_provider.dart';
import 'package:provider/provider.dart';

class TeamPointsModal extends StatefulWidget {
  final Team team;

  const TeamPointsModal({Key? key, required this.team}) : super(key: key);

  @override
  State<TeamPointsModal> createState() => _TeamPointsModalState();
}

class _TeamPointsModalState extends State<TeamPointsModal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberInputField(
            initialValue: widget.team.total.toString(),
            label: 'Total',
            onChanged: (value) {
              if (value.isNotEmpty) {
                widget.team.total = int.parse(value);
                context.read<TeamProvider>().updateTeam(widget.team);
              }
            }),
        NumberInputField(
          initialValue: widget.team.partial.toString(),
          label: 'Partial',
          onChanged: (value) {
            if (value.isNotEmpty) {
              widget.team.partial = int.parse(value);
              context.read<TeamProvider>().updateTeam(widget.team);
            }
          },
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
        ),
      ],
    );
  }
}
