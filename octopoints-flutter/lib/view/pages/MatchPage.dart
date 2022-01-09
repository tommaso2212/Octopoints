import 'package:flutter/material.dart';
import 'package:octopoints/model/model.dart';
import 'package:octopoints/provider/provider.dart';
import 'package:octopoints/view/pages/BasePage.dart';
import 'package:octopoints/view/widget/card/TeamCard.dart';
import 'package:octopoints/view/widget/modal/CreateTeamModal.dart';
import 'package:octopoints/view/widget/widget.dart';

class MatchPage extends BasePage<TeamModel> {
  final MatchModel _match;
  MatchPage(this._match);

  @override
  Future<List<Widget>> getAll(BuildContext context) =>
      context.select<IProvider<TeamModel>, Future<List<Widget>>>(
        (provider) => provider.getAll(byId: _match.id!).then(
              (list) => list
                  .map(
                    (e) => buildCard(context, e),
                  )
                  .toList(),
            ),
      );

  @override
  AppBar appBar(BuildContext context) => AppBar(
        title: Text(_match.description),
      );

  @override
  Widget buildCard(BuildContext context, team) => TeamCard(
        team,
        () => showModalBottomSheet(
          context: context,
          builder: (buildContext) => Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: modalBottomSheet(context, teamId: team.id),
          ),
          isScrollControlled: true,
          backgroundColor: OctopointsTheme.darkGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );

  @override
  Widget modalBottomSheet(BuildContext context, {int? teamId}) =>
      CreateTeamModal(
        context,
        _match.id!,
        teamId: teamId,
      );

  @override
  Widget body(BuildContext context, List<Widget>? children) => Container(
        height: MediaQuery.of(context).size.height * 0.86,
        child: PageView(
          children: children == null ? [] : children,
        ),
      );
}
