import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/theme/OctopointsTheme.dart';

import 'ConfirmDialog.dart';

class RoundedCard extends StatelessWidget {
  final Widget child;
  final void Function()? onDelete;
  final void Function()? onTap;
  final Color backgroundColor;

  const RoundedCard(this.child, {this.onDelete, this.onTap, this.backgroundColor = OctopointsTheme.lightGrey});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(7),
        ),
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            onDelete != null
                ? Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () =>
                      ConfirmDialog.show(context, 'Eliminare?')
                          .then((value) => value! ? onDelete!() : null),
                  icon: const Icon(Icons.delete),
                  color: Colors.white,
                ),
              ),
            )
                : const SizedBox.shrink(),
            Center(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
