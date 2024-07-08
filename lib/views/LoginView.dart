import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/firebase_options.dart';

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
        title: Text("Pakistan Zindabad Login Here"),
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: FutureBuilder(
          future: Firebase.initializeApp( 
            options: DefaultFirebaseOptions.currentPlatform,
                    ),
                    builder: (context, snapshot) {

                      switch (snapshot.connectionState){
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
                obscureText: false,
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () async {
                    
          
                    final email = _email.text;
                    final password = _password.text;

                    try {
                      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                    }

                    on FirebaseAuthException catch(e){

                      print(e.code);
                      if (e.code=='invalid-email'){
                        print('Your Email is Invalid');
                      }

                      else if(e.code=='wrong-password'){
                        print('Incorrect Password');
                      }

                      else if(e.code=='user-not-found'){
                        print('This Email is Not registererd');
                      }

                      else{
                        print('Something Went Wrong');  
                      }
                      


                    }
                    
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18),
                  ),
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
    );
  }

  
}