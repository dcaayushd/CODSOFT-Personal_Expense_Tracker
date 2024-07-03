import 'package:flutter/cupertino.dart';

void showAlertDialog(BuildContext context, Function destructiveCallback,
    String title, String content, String destructiveLabel,
    {String? cancelLabel, Function? cancellationCallback}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            cancellationCallback?.call();
            Navigator.pop(context);
          },
          child: Text(cancelLabel ?? 'Cancel'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            destructiveCallback();
            Navigator.pop(context);
          },
          child: Text(destructiveLabel),
        ),
      ],
    ),
  );
}
