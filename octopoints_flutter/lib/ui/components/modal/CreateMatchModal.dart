import 'package:flutter/material.dart';
import 'package:octopoints_flutter/service/model/Match.dart';
import 'package:octopoints_flutter/ui/components/RoundedTextField.dart';
import 'package:octopoints_flutter/ui/components/modal/CreateModal.dart';
import 'package:octopoints_flutter/ui/providers/MatchProvider.dart';
import 'package:octopoints_flutter/ui/theme/OctopointsTheme.dart';
import 'package:provider/provider.dart';

class CreateMatchModal extends StatefulWidget {
  final BuildContext context;
  const CreateMatchModal(this.context);

  @override
  _CreateMatchModalState createState() => _CreateMatchModalState();
}

class _CreateMatchModalState extends State<CreateMatchModal> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _playerController = TextEditingController();
  bool isFirstToTotal = true;

  @override
  void initState() {
    super.initState();
    _descriptionController.text = '';
    _pointsController.text = '3';
    _playerController.text = '1';
  }

  bool isValid() {
    if (_descriptionController.text.isEmpty) return false;
    if (_pointsController.text.isEmpty) return false;
    if (_playerController.text.isEmpty) return false;
    return true;
  }

  void createMatch() {
    context.read<MatchProvider>().add(Match(
          _descriptionController.text,
          isFirstToTotal ? GameMode.FIRST_TO_TOTAL : GameMode.LAST_TO_TOTAL,
          int.parse(_pointsController.text),
          int.parse(_playerController.text),
        ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CreateModal(
      title: 'Nuova partita',
      formInputs: [
        RoundedTextField(
          controller: _descriptionController,
          label: 'Nome Partita',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RoundedTextField(
                    controller: _pointsController, label: 'Limite punti',
              ),
            ),
            Expanded(
              child: RoundedTextField(
                  controller: _playerController, label: 'Numero vincitori',),
            ),
            
          ],
        ),
        /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: GestureDetector(
                      onTap: () => setState(() {
                        isFirstToTotal = true;
                      }),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border:
                              Border.all(color: OctopointsTheme.primaryColor),
                          color: isFirstToTotal
                              ? OctopointsTheme.primaryColor
                              : Colors.transparent,
                        ),
                        child: Text(
                          'Vincono i primi ad arrivare al limite',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: isFirstToTotal ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: GestureDetector(
                      onTap: () => setState(() {
                        isFirstToTotal = false;
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border:
                              Border.all(color: OctopointsTheme.primaryColor),
                          color: !isFirstToTotal
                              ? OctopointsTheme.primaryColor
                              : Colors.transparent,
                        ),
                        child: Text(
                          'Perdono i primi ad arrivare al limite',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                !isFirstToTotal ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),*/
      ],
      isValid: isValid(),
      onConfirm: () => createMatch(),
    );
  }
}
