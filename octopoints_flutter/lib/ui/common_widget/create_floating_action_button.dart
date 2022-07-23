import 'package:flutter/material.dart';

class CreateFloatingActionButton extends StatelessWidget {
  final Function()? onPressed;

  const CreateFloatingActionButton({Key? key, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
