import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/team.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/components/PointsInputField.dart';
import 'package:octopoints_flutter/ui/common_widget/rounded_card.dart';
import 'package:octopoints_flutter/ui/common_widget/text_input_field.dart';
import 'package:octopoints_flutter/ui/providers/TeamProvider.dart';
import 'package:octopoints_flutter/ui/theme/octopoints_theme.dart';
import 'package:provider/provider.dart';

class TeamPointsModal extends StatefulWidget {
  Team team;

  TeamPointsModal(this.team);

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
        PointsInputField(
            initialValue: widget.team.total.toString(),
            label: 'Total',
            onChanged: (value) {
              if (value.isNotEmpty) {
                widget.team.total = int.parse(value);
                context.read<TeamProvider>().updateTeam(widget.team);
              }
            }),
        PointsInputField(
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
