import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/components/FilterableList.dart';
import 'package:octopoints_flutter/ui/components/RoundedCard.dart';
import 'package:octopoints_flutter/ui/components/modal/BaseModal.dart';
import 'package:octopoints_flutter/ui/components/modal/TeamPointsModal.dart';
import 'package:octopoints_flutter/ui/pages/TeammatesPage.dart';
import 'package:octopoints_flutter/ui/providers/TeamProvider.dart';
import 'package:octopoints_flutter/ui/theme/OctopointsTheme.dart';
import 'package:provider/provider.dart';

class TeamPage extends StatelessWidget {
  final Match _match;
  late final TeamProvider _teamProvider;

  TeamPage(this._match) {
    _teamProvider = TeamProvider(_match);
  }

  Widget buildTeamCard(Team team, BuildContext context) {
    return RoundedCard(
      Container(
        margin: const EdgeInsets.only(right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Total: ",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  team.total.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  "Partial: ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  team.partial.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: team.status == TeamStatusEnum.win
          ? Color(0xff334B48)
          : team.status == TeamStatusEnum.lose
              ? Color(0xff442B37)
              : OctopointsTheme.lightGrey,
      onTap: () => BaseModal.showModal(
        context,
        ChangeNotifierProvider.value(
          value: _teamProvider,
          child: TeamPointsModal(team),
        ),
      ),
      onDelete: (() => _teamProvider.deleteTeam(team)),
      onLongPress: () async {
        team.users = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeammatesPage(team), //user page
          ),
        );
        context.read<TeamProvider>().updateTeam(team);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _match.name,
        ),
      ),
      body: ChangeNotifierProvider.value(
        value: _teamProvider,
        builder: (context, _) => FilterableList(
          list: context.select<TeamProvider, Future<List<Team>>>(
              (provider) => provider.data),
          elementToWidget: (team, context) => buildTeamCard(team, context),
        ),
      ),
    );
  }
}
