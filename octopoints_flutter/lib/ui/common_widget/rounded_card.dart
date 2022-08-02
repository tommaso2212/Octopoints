import 'package:flutter/material.dart';
import 'package:octopoints_flutter/ui/common_widget/confirm_dialog.dart';
import 'package:octopoints_flutter/ui/theme/octopoints_theme.dart';

class RoundedCard extends StatelessWidget {
  final Widget child;
  final void Function()? onDelete;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Color backgroundColor;

  const RoundedCard({
    Key? key,
    required this.child,
    this.onDelete,
    this.onTap,
    this.onLongPress,
    this.backgroundColor = OctopointsTheme.lightGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(7),
        ),
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            child,
            onDelete != null
                ? Positioned.directional(
                    end: 0,
                    textDirection: TextDirection.ltr,
                    child: GestureDetector(
                      onTap: () => ConfirmDialog.show(
                        context: context,
                        title: 'Delete?',
                        onConfirm: onDelete,
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: OctopointsTheme.primaryColor,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
