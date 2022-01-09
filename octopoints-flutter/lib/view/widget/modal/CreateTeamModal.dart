import 'package:flutter/material.dart';
import 'package:octopoints/model/model.dart';
import 'package:octopoints/provider/provider.dart';
import 'package:octopoints/view/widget/card/ClickableRoundedCard.dart';
import 'package:octopoints/view/widget/common/ConfirmButton.dart';

class CreateTeamModal extends StatelessWidget {
  final int matchId;
  final BuildContext context;
  final int? teamId;
  const CreateTeamModal(this.context, this.matchId, {this.teamId});
  @override
  Widget build(BuildContext buildContext) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Text(
              teamId == null ? 'Aggiungi squadra' : 'Aggiungi giocatore',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          teamId == null
              ? Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: ConfirmButton(() {
                    print(matchId);
                    context
                        .read<IProvider<TeamModel>>()
                        .add(TeamModel.insert(matchId));
                    Navigator.pop(buildContext);
                  }),
                )
              : FutureBuilder(
                  initialData: <UserModel>[],
                  future: context.read<IProvider<TeamModel>>().availableUsers(),
                  builder: (_, AsyncSnapshot<List<UserModel>> snapshot) =>
                      snapshot.connectionState == ConnectionState.done
                          ? Column(
                              children: snapshot.data!
                                  .map<Widget>((e) => ClickableRoundedCard(
                                      child: Text(e.username),
                                      onTap: () {
                                        context
                                            .read<IProvider<TeamModel>>()
                                            .joinTeam(teamId!, e);
                                        Navigator.pop(context);
                                      }))
                                  .toList())
                          : Container(),
                ),
        ],
      );
}
