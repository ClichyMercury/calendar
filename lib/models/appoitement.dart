import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Appointment {
  final String id;
  final String title;
  final DateTime? date;
  final String description;
  final String userId;

  Appointment({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.userId,
  });

  factory Appointment.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Appointment(
      id: snapshot.id,
      title: data['title'],
      date: data['date'].toDate(),
      description: data['description'],
      userId: data['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'description': description,
      'userId': userId,
    };
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String user = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addAppointment(Appointment appointment) {
    CollectionReference appointments =
        firestore.collection('user').doc(user).collection('appointments');

    return appointments.add(appointment.toMap());
  }
}
