import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Register"),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextField(
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                //MyExplorations
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 3, color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Enter your Email here."),
            controller: _email,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 3, color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Enter your Password here."),
            controller: _password,
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                Navigator.of(context).pushNamedAndRemoveUntil(
                    verifiedEmailRoute, (route) => false);
              } on FirebaseAuthException catch (e) {
                if (e.code == "weak-password") {
                  devtools.log("Weak Password");
                } else if (e.code == "email-already-in-use") {
                  devtools.log(
                      "Email is already in use"); //TODO:show something to user.
                } else if (e.code == "invalid-email") {
                  devtools.log(
                      "Email is an invalid-email."); //TODO:show something to user.
                }
                // devtools.log(e.code);
              }
            },
            child: const Center(child: Text("Register")),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text("Login Here!"),
          ),
        ],
      ),
    );
  }
}
