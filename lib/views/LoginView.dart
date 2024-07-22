import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/constants/routes.dart';
import 'package:notesapp/firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'package:notesapp/utillities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              ),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return Column(
                      children: [
                        TextField(
                          controller: _email,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20), // Add some space between the text fields
                        TextField(
                          controller: _password,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () async {
                                  final email = _email.text;
                                  final password = _password.text;
      
                                  try {
                                    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: email,
                                      password: password,
                                    );
                                    Navigator.of(context).pushNamedAndRemoveUntil(notesRoute, (route) => false,);
                                  } on FirebaseAuthException catch (e) {
                                    // print(e.code);
                                    if (e.code == 'invalid-email') {                                     
                                      // devtools.log('Your Email is Invalid');
                                      await showdialogue(context, 'Your Email is Invalid');
                                    } else if (e.code == 'wrong-password') {
                                      // devtools.log('Incorrect Password');
                                      await showdialogue(context, 'Incorrect Password');
                                    } else if (e.code == 'Your Email is Invalid') {
                                      // devtools.log('This Email is Not registered');
                                      await showdialogue(context, 'This Email is Not registered');
                                    } else {
                                      // devtools.log('Something Went Wrong');
                                      await showdialogue(context, 'Error: ${e.code}');
                                    }
                                  }
                                  catch(e){
                                    // devtools.log('Something Went Wrong');
                                    await showdialogue(context, e.toString(),);
                                  }
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      ],
                    );
                  default:
                    return Text("Loading...");
                }
              },
            ),
          ),
          Center(
            child: TextButton(
                         onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false,);
                            
                             },
                                    child: const Text('Register Here!'),
                                  ),
          ),
        ],
      ),
    );
  }
}

