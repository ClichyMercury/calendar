import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/auth.dart';
import '../data/landing_page.dart';
import '../widget/exception_alert_dialog.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emeilCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  bool _isLoading = false;

  void _submit(context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.createUserWithEmailAndPassword(
          emeilCtrl.text, passwordCtrl.text);

      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => LandingPage()));
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      showExecptionALertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExecptionALertDialog(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Calendar",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),
              Text('Inscription'),
              SizedBox(height: 10),
              TextFormField(
                controller: emeilCtrl,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    hintTextDirection: TextDirection.ltr,
                    label: const Text("Email")),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordCtrl,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    hintTextDirection: TextDirection.ltr,
                    label: const Text("Password")),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    _submit(context);
                  },
                  child: const Text("Inscription")),
              const SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }
}
