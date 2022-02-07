import 'package:flutter/material.dart';

class CommonFAB extends FloatingActionButton {
  CommonFAB({void Function()? onPressed})
      : super(
          onPressed: onPressed,
          child: Icon(Icons.add),
        );
}
