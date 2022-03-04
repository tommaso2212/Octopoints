import 'package:flutter/material.dart';

class CreateFAB extends FloatingActionButton {
  CreateFAB({void Function()? onPressed})
      : super(
    onPressed: onPressed,
    child: Icon(Icons.add),
  );
}