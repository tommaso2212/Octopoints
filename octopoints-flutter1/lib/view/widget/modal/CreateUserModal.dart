import 'package:flutter/material.dart';
import 'package:octopoints/model/UserModel.dart';
import 'package:octopoints/provider/IProvider.dart';
import 'package:provider/provider.dart';

import '../widget.dart';

class CreateUserModal extends StatefulWidget {
  final BuildContext context;
  CreateUserModal(this.context);
  @override
  _CreateUserModalState createState() => _CreateUserModalState();
}

class _CreateUserModalState extends State<CreateUserModal> {
  TextEditingController _controller = TextEditingController();
  bool isValid = false;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Text(
              'Crea nuovo giocatore',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: TextField(
              controller: _controller,
              onChanged: (value) => setState(
                  () => value != '' ? isValid = true : isValid = false),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Username',
                label: Text(
                  'Username',
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
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConfirmButton(!isValid
                ? null
                : () {
                    widget.context
                        .read<IProvider<UserModel>>()
                        .add(UserModel.insert(_controller.text));
                    Navigator.pop(context);
                  }),
          ),
        ],
      );
}
