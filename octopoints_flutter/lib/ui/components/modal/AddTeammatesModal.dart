import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/common_widget/confirm_button.dart';
import 'package:octopoints_flutter/ui/components/FilterableList.dart';
import 'package:octopoints_flutter/ui/components/RoundedCard.dart';
import 'package:octopoints_flutter/ui/pages/TeammatesPage.dart';
import 'package:octopoints_flutter/ui/providers/TeammatesProvider.dart';
import 'package:octopoints_flutter/ui/theme/octopoints_theme.dart';
import 'package:provider/provider.dart';

class AddTeammatesModal extends StatefulWidget {
  final Team _team;
  AddTeammatesModal(this._team);

  @override
  State<AddTeammatesModal> createState() => _AddTeammatesModalState();
}

class _AddTeammatesModalState extends State<AddTeammatesModal> {
  Map<User, bool> users = Map.identity();
  Set<User> teammatesToAdd = Set.identity();
  Set<User> teammatesToRemove = Set.identity();

  @override
  void initState() {
    super.initState();
    OctopointsService.teamService
        .getAvailableTeammates(widget._team)
        .then((value) => setState(() {
          users = value;
        }));
  }

  void onConfirm(BuildContext context) {
    context.read<TeammatesProvider>().addTeammates(teammatesToAdd.toList());
    for (User user in teammatesToRemove) {
      context.read<TeammatesProvider>().leaveTeam(user);
    }
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
            "Aggiungi giocatore",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        

        users.isNotEmpty ? SingleChildScrollView(
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                MapEntry<User, bool> mapEntry = users.entries.elementAt(index);
                return RoundedCard(
                  Text(
                    mapEntry.key.username,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: mapEntry.value ? OctopointsTheme.primaryColor : OctopointsTheme.darkGrey,
                  onTap: () {
                    if(mapEntry.value && !teammatesToAdd.remove(mapEntry.key)){
                      teammatesToRemove.add(mapEntry.key);
                    }
                    if(!mapEntry.value && !teammatesToRemove.remove(mapEntry.key)){
                      teammatesToAdd.add(mapEntry.key);
                    }
                    setState(() {
                      users.update(mapEntry.key, (value) => !value);
                    });
                  },
                );
              },
            ),
          ),
        ) : const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Text(
            "Nessun giocatore disponibile",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
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
