
import 'package:flutter/material.dart';
import 'package:notesapp/constants/routes.dart';
import 'package:notesapp/services/auth/authExceptions.dart';
import 'package:notesapp/services/auth/authServices.dart';

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
              future: authServices.firebase().initialize(),
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
                                    final userCredential = await authServices.firebase().login(email: email, password: password);
                                    final user= authServices.firebase().currentUser;

                                    if(user?.isEmailVerified ?? false){
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                      notesRoute,
                                      (route) => false,
                                    );

                                    }
                                    else{
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                      verifyEmailRoute,
                                      (route) => false,
                                      );
                                    }

                                  }
                                  
                                  on UserNotFoundAuthException{
                                      await showdialogue(
                                          context, 'User Not Registerd');
                                  }
                                  
                                  on WrongPasswordAuthException{
                                       await showdialogue(
                                          context, 'Incorrect Password');
                                  }

                                  on GenericAuthException{
                                      await showdialogue(
                                      context,
                                      'Authentication Error',);
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
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute, (route) => false, );
              },
              child: const Text('Register Here!'),
            ),
          ),
        ],
      ),
    );
  }
}

