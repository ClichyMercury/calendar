import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'custum_alert_dialog.dart';

Future<void> showExecptionALertDialog(
  BuildContext context, {
  required String title,
  required Exception exception,
}) =>
    showCustumAlertDiaolog(
        icon: Icons.warning,
        context,
        title: title,
        content: _message(exception),
        defaultActionText: "OK",
        cancelActionText: '');

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message!;
  }
  return exception.toString();
}
