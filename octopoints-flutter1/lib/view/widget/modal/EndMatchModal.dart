import 'package:flutter/material.dart';
import 'package:octopoints/model/model.dart';
import 'package:octopoints/provider/provider.dart';
import 'package:octopoints/view/pages/HomePage.dart';
import 'package:octopoints/view/widget/widget.dart';

class EndMatchModal extends StatelessWidget {
  final BuildContext context;
  EndMatchModal(this.context);
  @override
  Widget build(BuildContext buildContext) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Text(
              'Partita terminata',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Text(
              'Vincitori',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Column(
            children: context
                .read<IProvider<TeamModel>>()
                .winners
                .map<Widget>((e) => RoundedCard(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(e),
                      ),
                    ))
                .toList(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Text(
              'Eliminare la partita?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConfirmButton(() {
              context.read<IProvider<TeamModel>>().updateUsersStats();
              Navigator.pop(context, true);
            }),
          ),
        ],
      );
}
