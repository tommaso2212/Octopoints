import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/card/team_card.dart';
import 'package:octopoints_flutter/ui/common_widget/create_floating_action_button.dart';
import 'package:octopoints_flutter/ui/common_widget/filterable_list.dart';
import 'package:octopoints_flutter/ui/modal/base_modal.dart';
import 'package:octopoints_flutter/ui/modal/teammates_modal.dart';
import 'package:octopoints_flutter/ui/providers/team_provider.dart';
import 'package:provider/provider.dart';

class TeamPage extends StatelessWidget {
  final Match match;
  late final TeamProvider _teamProvider;

  TeamPage({Key? key, required this.match}) : super(key: key) {
    _teamProvider = TeamProvider(match);
  }

  Widget buildListItem(BuildContext context, int index, String textFilter) {
    Team team = context.watch<TeamProvider>().data[index];
    if(textFilter.isNotEmpty && !team.users.any((user) => user.username.contains(textFilter))){
            return const SizedBox.shrink();
    }
    return TeamCard(team: team);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          match.name,
        ),
        actions: [
          ChangeNotifierProvider.value(
            value: _teamProvider,
            builder: (context, _) => IconButton(
              onPressed: () => context.read<TeamProvider>().sortListByTotal(),
              icon: const Icon(Icons.bar_chart_rounded),
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider.value(
        value: _teamProvider,
        builder: (context, _) => FilterableList(
          listKey: context.read<TeamProvider>().listKey,
          initialItemCount: context
              .select<TeamProvider, int>((provider) => provider.data.length),
          itemBuilder: (context, index, textFilter) =>
              buildListItem(context, index, textFilter),
        ),
      ),
      floatingActionButton: ChangeNotifierProvider.value(
        value: _teamProvider,
        builder: (context, _) => CreateFloatingActionButton(
          onPressed: () async {
            Team team = await context.read<TeamProvider>().createTeam();
            BaseModal.showModal(
                  context,
                  ChangeNotifierProvider.value(
                    value: context.read<TeamProvider>(),
                    child: TeammatesModal(
                      team: team,
                    ),
                  ),
                );
          },
        ),
      ),
    );
  }
}
