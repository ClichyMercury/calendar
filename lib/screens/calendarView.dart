import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/data/auth.dart';
import 'package:task_app/data/database_manager.dart';
import '../widget/add_task_dialog.dart';
import '../widget/custum_alert_dialog.dart';
import '../models/appoitement.dart';
import 'addAppoitement.dart';
import 'calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  bool checkValue = false;
  List tasksLList = [];
  String docID = '';
  String user = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _signOut() async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final disRequestSignOut = await showCustumAlertDiaolog(
      context,
      content: 'Are you sure you want logout ?',
      defaultActionText: 'Logout',
      icon: Icons.warning,
      title: 'Logout',
      cancelActionText: 'Cancel',
    );
    if (disRequestSignOut == true) {
      _signOut();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  fecthdatabaseList() async {
    dynamic resultant = await databaseManager().getTasksList();

    if (resultant == null) {
      print("Unable to retrive");
    } else {
      setState(() {
        tasksLList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _confirmSignOut(context);
            },
            icon: const Icon(Icons.logout)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Calendar'),
        actions: [
          TextButton(
            child: Text('Open Calendar'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return CalendarPage();
                  }),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(user)
            .collection('appointments')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Erreur : ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          List<Appointment> appointments = snapshot.data!.docs
              .map((QueryDocumentSnapshot doc) => Appointment.fromSnapshot(doc))
              .toList();

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              Appointment appointment = appointments[index];

              return Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.purple),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(children: [
                  SizedBox(height: 20),
                  Text(
                    appointment.title,
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(appointment.date.toString()),
                  SizedBox(height: 10),
                  Text(appointment.description),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(user)
                                .collection('appointments')
                                .doc(appointment.id)
                                .delete()
                                .then((value) {
                              print('Document supprimé avec succès');
                            }).catchError((error) {
                              print(
                                  'Erreur lors de la suppression du document : $error');
                            });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  )
                ]),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddAppointmentScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
