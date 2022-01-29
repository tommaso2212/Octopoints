import 'package:flutter/material.dart';
import 'package:octopoints/model/model.dart';
import 'package:octopoints/provider/provider.dart';
import 'package:octopoints/view/widget/modal/EndMatchModal.dart';
import 'package:octopoints/view/widget/widget.dart';

class TeamCard extends StatefulWidget {
  final TeamModel _team;
  final void Function() onTap;
  TeamCard(this._team, this.onTap);

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  final TextEditingController _totalController = TextEditingController();

  final TextEditingController _partialController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _totalController.text = widget._team.total.toString();
    _partialController.text = widget._team.partial.toString();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          if (_totalController.text != '') {
            if (int.parse(_totalController.text) != widget._team.total) {
              context.read<IProvider<TeamModel>>().update(
                  widget._team.setTotal(int.parse(_totalController.text)));
            }
          } else {
            _totalController.text = widget._team.total.toString();
          }

          if (_partialController.text != '') {
            if (int.parse(_partialController.text) != widget._team.partial) {
              context.read<IProvider<TeamModel>>().update(
                  widget._team.setPartial(int.parse(_partialController.text)));
            }
          } else {
            _partialController.text = widget._team.partial.toString();
          }
          widget.onTap();
        },
        child: RoundedCard(
          backgroundColor: OctopointsTheme.darkGrey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: TextField(
                        controller: _totalController,
                        onTap: () => _totalController.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: _totalController.text.length,
                        ),
                        onSubmitted: (value) => value != ''
                            ? context
                                .read<IProvider<TeamModel>>()
                                .update(widget._team.setTotal(int.parse(value)))
                                .then(
                                  (isGameOver) => isGameOver
                                      ? showModalBottomSheet<bool>(
                                          context: context,
                                          builder: (buildContext) => Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 40, horizontal: 20),
                                            child: EndMatchModal(context),
                                          ),
                                          isScrollControlled: true,
                                          backgroundColor:
                                              OctopointsTheme.darkGrey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ).then((value) => value != null && value
                                          ? Navigator.pop(context, true)
                                          : null)
                                      : null,
                                )
                            : _totalController.text =
                                widget._team.total.toString(),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide:
                                BorderSide(color: OctopointsTheme.primaryColor),
                          ),
                          label: Text(
                            'Total',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: TextField(
                        controller: _partialController,
                        onSubmitted: (value) => value != ''
                            ? context.read<IProvider<TeamModel>>().update(
                                widget._team.setPartial(int.parse(value)))
                            : _partialController.text =
                                widget._team.partial.toString(),
                        onTap: () =>
                            _partialController.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: _partialController.text.length,
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide:
                                BorderSide(color: OctopointsTheme.primaryColor),
                          ),
                          label: Text(
                            'Partial',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: widget._team.users
                        .map<Widget>(
                          (e) => RoundedCard(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(e.username),
                            ),
                            onDelete: () => context
                                .read<IProvider<TeamModel>>()
                                .leaveTeam(widget._team.id!, e.id!),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          hasGradient: false,
          onDelete: () =>
              context.read<IProvider<TeamModel>>().remove(widget._team),
        ),
      );
}
