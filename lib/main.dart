// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Notes',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginVeiw(),
        '/register/': (context) => const RegisterView(),
        '/verify/': (context) => const VerifiedEmailView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              if (user.emailVerified) {
                return const NotesView();
              } else {
                return const VerifiedEmailView();
              }
            } else {
              return const LoginVeiw();
            }
            // if (user?.emailVerified ?? false) {
            //   return const Center(
            //     child: Text("Done"),
            //   );
            // } else {
            //   print(user);
            //   return const VerifiedEmailView();
            // }

            return const Text("Done");
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Notes Home Page"),
        ),
        actions: <Widget>[
          //myExplorations
          IconButton(
            //myExplorations
            icon: const Icon(Icons.add), //myExplorations
            tooltip: 'Show Snackbar', //myExplorations
            onPressed: () {
              //myExplorations
              ScaffoldMessenger.of(context).showSnackBar(//myExplorations
                  const SnackBar(
                      content: Text('This is a snackbar'))); //myExplorations
            }, //myExplorations
          )
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text("Home"),
        ),
      ),
    );
  }
}
