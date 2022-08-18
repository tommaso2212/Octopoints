import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/common_widget/confirm_button.dart';
import 'package:octopoints_flutter/ui/common_widget/filterable_list.dart';
import 'package:octopoints_flutter/ui/common_widget/rounded_card.dart';
import 'package:octopoints_flutter/ui/providers/team_provider.dart';
import 'package:octopoints_flutter/ui/theme/octopoints_theme.dart';
import 'package:provider/provider.dart';

class TeammatesModal extends StatefulWidget {
  final Team team;
  const TeammatesModal({Key? key, required this.team}) : super(key: key);

  @override
  State<TeammatesModal> createState() => _TeammatesModalState();
}

class _TeammatesModalState extends State<TeammatesModal> {
  Map<User, bool> users = Map.identity();

  @override
  void initState() {
    super.initState();
    OctopointsService.teamService
        .getAvailableTeammates(widget.team)
        .then((value) => setState(() {
              users = value;
            }));
  }

  Widget buildTeammateCard(BuildContext context, int index, String textFilter) {
    MapEntry<User, bool> mapEntry = users.entries.elementAt(index);
    if (mapEntry.key.username.contains(textFilter)) {
      return RoundedCard(
        child: Text(
          mapEntry.key.username,
          overflow: TextOverflow.clip,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: mapEntry.value
            ? OctopointsTheme.primaryColor
            : OctopointsTheme.darkGrey,
        onTap: () {
          setState(() {
            users[mapEntry.key] = !mapEntry.value;
          });
        },
      );
    }
    return const SizedBox.shrink();
  }

  void onConfirm(BuildContext context) {
    widget.team.users = users.entries
        .where((element) => element.value)
        .map((e) => e.key)
        .toList();
    context.read<TeamProvider>().updateTeammates(widget.team);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 14),
          child: Text(
            "Select teammates",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: FilterableList(
            itemBuilder: (context, index, textFilter) =>
                buildTeammateCard(context, index, textFilter),
            listKey: GlobalKey<AnimatedListState>(),
            initialItemCount: users.length,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConfirmButton(
            onPressed: () => onConfirm(context),
          ),
        ),
      ],
    );
  }
}
