import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/Team.dart';
import 'package:octopoints_flutter/service/service.dart';
import 'package:octopoints_flutter/ui/components/RoundedCard.dart';
import 'package:octopoints_flutter/ui/components/TextInputField.dart';
import 'package:octopoints_flutter/ui/providers/TeamProvider.dart';
import 'package:octopoints_flutter/ui/theme/OctopointsTheme.dart';
import 'package:provider/provider.dart';

class TeamPointsModal extends StatefulWidget {
  Team team;

  TeamPointsModal(this.team);

  @override
  State<TeamPointsModal> createState() => _TeamPointsModalState();
}

class _TeamPointsModalState extends State<TeamPointsModal> {
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _partialController = TextEditingController();

  bool isTotalValid = true;
  bool isPartialValid = true;

  @override
  void initState() {
    super.initState();
    _totalController.text = widget.team.total.toString();
    _partialController.text = widget.team.partial.toString();
  }

  void updateTeam(BuildContext context) {
    if (isPartialValid && isTotalValid) {
      context.read<TeamProvider>().updateTeam(widget.team);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                widget.team.total--;
                _totalController.text = widget.team.total.toString();
                updateTeam(context);
              },
              icon: const Icon(
                Icons.remove,
                size: 40,
                color: OctopointsTheme.primaryColor,
              ),
              padding: const EdgeInsets.only(bottom: 60),
            ),
            SizedBox(
              width: 180,
              height: 100,
              child: TextInputField(
                initialValue: widget.team.total.toString(),
                label: 'Total',
                textInputType:
                    const TextInputType.numberWithOptions(signed: true),
                autoFocus: false,
                onChanged: (value) => setState(() {
                  isTotalValid = _totalController.text.isNotEmpty;
                  if (isTotalValid) {
                    widget.team.total = int.parse(_totalController.text);
                    updateTeam(context);
                  }
                }),
              ),
            ),
            IconButton(
              onPressed: () {
                widget.team.total++;
                _totalController.text = widget.team.total.toString();
                updateTeam(context);
              },
              icon: const Icon(
                Icons.add,
                size: 40,
                color: OctopointsTheme.primaryColor,
              ),
              padding: const EdgeInsets.only(bottom: 60),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                widget.team.partial--;
                _partialController.text = widget.team.partial.toString();
                updateTeam(context);
              },
              icon: const Icon(
                Icons.remove,
                size: 35,
                color: OctopointsTheme.primaryColor,
              ),
              padding: const EdgeInsets.only(bottom: 55),
            ),
            SizedBox(
              width: 150,
              height: 100,
              child: TextInputField(
                initialValue: widget.team.partial.toString(),
                label: 'Partial',
                textInputType:
                    const TextInputType.numberWithOptions(signed: true),
                autoFocus: false,
                onChanged: (value) => setState(() {
                  isPartialValid = _partialController.text.isNotEmpty;
                  if (isPartialValid) {
                    widget.team.partial = int.parse(_partialController.text);
                    updateTeam(context);
                  }
                }),
              ),
            ),
            IconButton(
              onPressed: () {
                widget.team.partial++;
                _partialController.text = widget.team.partial.toString();
                updateTeam(context);
              },
              icon: const Icon(
                Icons.add,
                size: 35,
                color: OctopointsTheme.primaryColor,
              ),
              padding: const EdgeInsets.only(bottom: 55),
            ),
          ],
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: widget.team.users.length,
            itemBuilder: (context, index) {
              User user = widget.team.users[index];
              return RoundedCard(
                Container(
                  margin: const EdgeInsets.only(right: 40),
                  child: Text(
                    user.username,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                backgroundColor: OctopointsTheme.darkGrey,
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
        ),
      ],
    );
  }
}
