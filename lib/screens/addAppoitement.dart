import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appoitement.dart';

class AddAppointmentScreen extends StatefulWidget {
  @override
  _AddAppointmentScreenState createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? _selectedDate;
  String user = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _saveAppointment() {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text.trim();
      String description = _descriptionController.text.trim();

      // Création de l'objet Appointment
      Appointment appointment = Appointment(
          title: title,
          date: _selectedDate,
          description: description,
          userId: user,
          id: '');

      // Enregistrement du rendez-vous dans Firestore
      FirebaseFirestore.instance
          .collection('user')
          .doc(user)
          .collection('appointments')
          .add(appointment.toMap())
          .then((value) {
        // Succès de l'enregistrement du rendez-vous
        Navigator.pop(context); // Retour à l'écran précédent
      }).catchError((error) {
        // Erreur lors de l'enregistrement du rendez-vous
        print('Erreur lors de l\'enregistrement du rendez-vous : $error');
        // Afficher un message d'erreur ou effectuer d'autres actions
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouveau rendez-vous'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Titre',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un titre';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Date',
                    ),
                    child: Text(
                      _selectedDate != null
                          ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                          : 'Sélectionner une date',
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  maxLines: 5,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _saveAppointment,
                  child: Text('Enregistrer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
