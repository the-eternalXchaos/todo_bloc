import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;

  final bool Function()? onConfirm;

  const AppAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(
              context,
            ).colorScheme.onSurfaceVariant.withAlpha(100),
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (onConfirm != null) {
              if (onConfirm!()) {
                Navigator.of(context).pop();
              }
            } else {
              Navigator.of(context).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
