import 'package:flutter/material.dart';
import 'package:octopoints/model/model.dart';
import 'package:octopoints/provider/provider.dart';
import 'package:octopoints/view/pages/MatchPage.dart';
import 'package:octopoints/view/widget/card/ClickableRoundedCard.dart';

class MatchCard extends StatelessWidget {
  final MatchModel _match;

  MatchCard(this._match);

  @override
  Widget build(BuildContext context) => ClickableRoundedCard(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          alignment: AlignmentDirectional.topStart,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              _match.description,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
        onDelete: () => context.read<IProvider<MatchModel>>().remove(_match),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MatchPage(_match),
          ),
        ),
      );
}
