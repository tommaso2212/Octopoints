import 'package:flutter/material.dart';
import 'package:octopoints/model/model.dart';
import 'package:octopoints/provider/provider.dart';
import 'package:octopoints/view/widget/widget.dart';

class CreateMatchModal extends StatefulWidget {
  final BuildContext context;
  const CreateMatchModal(this.context);

  @override
  _CreateMatchModalState createState() => _CreateMatchModalState();
}

class _CreateMatchModalState extends State<CreateMatchModal> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _pointsController = TextEditingController();
  TextEditingController _playerController = TextEditingController();
  bool _isValid = false;
  bool isLastToTotal = false;

  bool isValid() {
    if (_descriptionController.text.isEmpty) return false;
    if (_pointsController.text.isEmpty) return false;
    if (_playerController.text.isEmpty) return false;
    return true;
  }

  @override
  void initState() {
    super.initState();
    _pointsController.text = '3';
    _playerController.text = '1';
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Text(
              'Crea nuova partita',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: TextField(
              controller: _descriptionController,
              onChanged: (value) => setState(() {
                _isValid = isValid();
              }),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Nome partita',
                label: Text(
                  'Nome partita',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: OctopointsTheme.primaryColor),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: TextField(
                      controller: _pointsController,
                      keyboardType: TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      onChanged: (value) => setState(() {
                        _isValid = isValid();
                      }),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      autofocus: true,
                      decoration: InputDecoration(
                        label: Text(
                          'Limite punti',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide:
                              BorderSide(color: OctopointsTheme.primaryColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: _playerController,
                      keyboardType: TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      onChanged: (value) => setState(() {
                        _isValid = isValid();
                      }),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      autofocus: true,
                      decoration: InputDecoration(
                        label: Text(
                          'Numero vincitori',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide:
                              BorderSide(color: OctopointsTheme.primaryColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Vincono i primi ad arrivare al limite',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: isLastToTotal ? 14 : 16),
                  ),
                ),
                Switch(
                  value: isLastToTotal,
                  onChanged: (value) => setState(() {
                    isLastToTotal = value;
                  }),
                  activeColor: OctopointsTheme.primaryColor,
                ),
                Expanded(
                  child: Text(
                    'Perdono i primi ad arrivare al limite',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: isLastToTotal ? 16 : 14),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConfirmButton(!_isValid
                ? null
                : () {
                    widget.context.read<IProvider<MatchModel>>().add(
                          MatchModel.insert(
                            _descriptionController.text,
                            isLastToTotal
                                ? GameMode.lastToTotal
                                : GameMode.firstToTotal,
                            int.parse(_pointsController.text),
                            int.parse(_playerController.text),
                          ),
                        );
                    Navigator.pop(context);
                  }),
          ),
        ],
      );
}
