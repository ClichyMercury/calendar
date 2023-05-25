import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class databaseManager {


  Future getTasksList() async {
    List tasksList = [];
    String user = FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseFirestore.instance
            .collection('user')
            .doc(user)
            .collection('appointments').get().then((value) {
        for (var element in value.docs) {
          tasksList.add(element.data());
        }
      });
      return tasksList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


}