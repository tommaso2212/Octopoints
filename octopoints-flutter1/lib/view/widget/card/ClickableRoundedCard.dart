import 'package:flutter/material.dart';
import 'package:octopoints/view/widget/card/RoundedCard.dart';

class ClickableRoundedCard extends RoundedCard {
  final void Function()? onTap;
  ClickableRoundedCard(
      {required Widget child, void Function()? onDelete, required this.onTap})
      : super(child: child, onDelete: onDelete);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: this.onTap,
        child: RoundedCard(
          child: child,
          onDelete: onDelete,
        ),
      );
}
