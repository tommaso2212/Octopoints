import 'package:flutter/material.dart';
import 'package:octopoints/view/theme/OctopointsTheme.dart';
import 'package:octopoints/view/widget/common/ConfirmDialog.dart';

class RoundedCard extends StatelessWidget {
  final Widget? child;
  final void Function()? onDelete;
  final Color backgroundColor;
  final bool hasGradient;
  RoundedCard({
    this.child,
    this.onDelete,
    this.backgroundColor = OctopointsTheme.lightGrey,
    this.hasGradient = true,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          gradient: hasGradient
              ? LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [
                      .05,
                      .01
                    ],
                  colors: [
                      OctopointsTheme.randomColor,
                      backgroundColor,
                    ])
              : null,
          color: hasGradient ? null : backgroundColor,
          borderRadius: BorderRadius.circular(7),
        ),
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            this.onDelete != null
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () =>
                            ConfirmDialog.show(context, 'Eliminare?')
                                .then((value) => value! ? onDelete!() : null),
                        icon: Icon(Icons.delete),
                        color: Colors.white,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Center(
              child: this.child,
            ),
          ],
        ),
      );
}
