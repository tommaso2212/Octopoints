import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/common_widget/number_input_field.dart';
import 'package:octopoints_flutter/ui/common_widget/rounded_card.dart';
import 'package:octopoints_flutter/ui/modal/base_modal.dart';
import 'package:octopoints_flutter/ui/modal/end_match_modal.dart';
import 'package:octopoints_flutter/ui/modal/teammates_modal.dart';
import 'package:octopoints_flutter/ui/providers/team_provider.dart';
import 'package:octopoints_flutter/ui/theme/octopoints_theme.dart';
import 'package:provider/provider.dart';

class TeamCard extends StatelessWidget {
  final Team team;

  const TeamCard({Key? key, required this.team}) : super(key: key);

  void updateTeamTotal(BuildContext context, String total) {
    if (total.isNotEmpty) {
      team.total = int.parse(total);
      context.read<TeamProvider>().updateTeam(team);
      if (context.read<TeamProvider>().endMatch()) {
        BaseModal.showModal(
          context,
          ChangeNotifierProvider.value(
            value: context.read<TeamProvider>(),
            child: const EndMatchModal(),
          ),
        );
      }
    }
  }

  void updateTeamPartial(BuildContext context, String partial) {
    if (partial.isNotEmpty) {
      team.partial = int.parse(partial);
      context.read<TeamProvider>().updateTeam(team);
    }
  }

  Color getBackgroundColorByStatus() {
    switch (team.status) {
      case TeamStatusEnum.playing:
        return OctopointsTheme.lightGrey;
      case TeamStatusEnum.win:
        return const Color(0xff334B48);
      case TeamStatusEnum.lose:
        return const Color(0xff442B37);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Container(
        margin: const EdgeInsets.only(right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: NumberInputField(
                initialValue: team.total.toString(),
                label: "Total",
                onChanged: (value) => updateTeamTotal(context, value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: NumberInputField(
                initialValue: team.partial.toString(),
                label: "Partial",
                onChanged: (value) => updateTeamPartial(context, value),
              ),
            ),
            Wrap(
              spacing: 8,
              children: team.users
                  .map(
                    (e) => Chip(
                      label: Text(
                        e.username,
                      ),
                      backgroundColor: Colors.grey,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      backgroundColor: getBackgroundColorByStatus(),
      onDelete: (() => context.read<TeamProvider>().deleteTeam(team)),
      onLongPress: () => BaseModal.showModal(
        context,
        ChangeNotifierProvider.value(
          value: context.read<TeamProvider>(),
          child: TeammatesModal(
            team: team,
          ),
        ),
      ),
    );
  }
}
