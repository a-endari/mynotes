import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifiedEmailView extends StatefulWidget {
  const VerifiedEmailView({super.key});

  @override
  State<VerifiedEmailView> createState() => _VerifiedEmailViewState();
}

class _VerifiedEmailViewState extends State<VerifiedEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Verify Email"),
        ),
      ),
      body: Column(children: [
        const Center(
          child: Text("Please Verify your Email.com"),
        ),
        TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: const Text("Send Verification Email"),
        )
      ]),
    );
  }
}
