import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/common_widget/confirm_button.dart';
import 'package:octopoints_flutter/ui/providers/match_provider.dart';
import 'package:octopoints_flutter/ui/providers/team_provider.dart';
import 'package:provider/provider.dart';

class EndMatchModal extends StatelessWidget {
  const EndMatchModal({Key? key}) : super(key: key);

  Chip buildUserChip(User user) {
    return Chip(
      label: Text(
        user.username,
      ),
      backgroundColor: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Winners",
          style: TextStyle(fontSize: 28),
        ),
        Wrap(
          spacing: 8,
          children: context
              .select<TeamProvider, List<User>>(
                  (provider) => provider.getWinningUsers())
              .map((user) => buildUserChip(user))
              .toList(),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 14,
          ),
          child: Text(
            "Delete match?",
            style: TextStyle(fontSize: 24),
          ),
        ),
        ConfirmButton(
          onPressed: () {
            context.read<TeamProvider>().deleteMatch();
            Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
          },
        )
      ],
    );
  }
}
