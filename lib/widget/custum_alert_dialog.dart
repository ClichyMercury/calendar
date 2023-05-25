import 'package:flutter/material.dart';

Future showCustumAlertDiaolog(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String content,
  required String cancelActionText,
  required String defaultActionText,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(icon),
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: Text(
            content,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelActionText),
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(defaultActionText))
          ],
        );
      });
}
