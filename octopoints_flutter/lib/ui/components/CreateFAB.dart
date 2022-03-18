import 'package:flutter/material.dart';

class CreateFAB extends FloatingActionButton {
  const CreateFAB({void Function()? onPressed})
      : super(
    onPressed: onPressed,
    child: const Icon(Icons.add),
  );
}