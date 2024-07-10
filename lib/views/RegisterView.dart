import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/firebase_options.dart';

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
      body: Column(
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
                        try{
                          final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                        }
        
                        on FirebaseAuthException catch(e){
                          print (e.code);
                          if(e.code=='weak-password'){
                            print('Your Password is Weak');
                          }
        
                          else if(e.code=='invalid-email'){
                            print('Invalid Email');
                          }
                           else if(e.code=='email-already-in-use'){
                            print('This Email is Already Registerd');
                          }
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
                        Navigator.of(context).pushNamedAndRemoveUntil('/login/', (route) => false);
                          
                           },
                                  child: const Text('Login If You Already Have an Account'),
                                ),
        ),
                ],
              ),
    );
  }
}