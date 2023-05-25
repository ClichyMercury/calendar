import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'custum_alert_dialog.dart';

Future showAlertDialog(BuildContext context) async {
  TextEditingController titlectrl = TextEditingController();
  TextEditingController desctrl = TextEditingController();

  void _saveSettings() async {
    await Firebase.initializeApp();

    CollectionReference users =
        FirebaseFirestore.instance.collection('userTasks');
    final user = FirebaseAuth.instance.currentUser!;
    String userId = user.uid;

    await users.doc().set({
      'id': userId,
      'title': titlectrl.text,
      'decription': desctrl.text,
    });

    showCustumAlertDiaolog(context,
        title: "Task added !",
        content: "Task saved succefully",
        defaultActionText: "Done",
        icon: Icons.check_box,
        cancelActionText: '');

    ;
  }


  return showDialog(
    context: context,
    builder: ((context) {
      return AlertDialog(
        icon: const Text(
          'Add Task',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        title: TextField(
            controller: titlectrl,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                hintTextDirection: TextDirection.ltr,
                label: const Text('Title'))),
        content: TextField(
            maxLines: 5,
            controller: desctrl,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                hintTextDirection: TextDirection.ltr,
                label: const Text('description'))),
        actions: [
          ElevatedButton(
              onPressed: () {
                _saveSettings();
                
              },
              child: const Text('Add')),
        ],
      );
    }),
  );
}
