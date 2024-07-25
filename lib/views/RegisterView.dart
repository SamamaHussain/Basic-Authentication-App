
import 'package:flutter/material.dart';
import 'package:notesapp/constants/routes.dart';
import 'package:notesapp/services/auth/authExceptions.dart';
import 'package:notesapp/services/auth/authServices.dart';

import 'package:notesapp/utillities/show_error_dialog.dart';

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
    print("Pakistan");
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
        title: const Text('Register Here'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                      obscureText: false,
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          
                
                          final email = _email.text;
                          final password = _password.text;
                          try {
                            await authServices.firebase().createUser(email: email, password: password);
                            Navigator.of(context).pushNamed(verifyEmailRoute);
                            await authServices.firebase().sendVerificationEmail();
                  } 
                  on WeakPasswordAuthException {
                      await showdialogue(context, 'Your Password is Weak');
                  }
                  on InvalidEmailAuthException {
                     await showdialogue(context, 'Invalid Email');
                  }
                  
                  on EmailAlreadyInUseAuthException {
                      await showdialogue(
                          context, 'This Email is Already Registerd');
                  }
                  
                  on GenericAuthException {
                      await showdialogue(
                      context,
                     'Authentication Error',
                    );
                  }                 
               },
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },
                child: Text('Login If You Already Have an Account'),
              ),
            ),
                  ],
                ),
      ),
    );
  }
}