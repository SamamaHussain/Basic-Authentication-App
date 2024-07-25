import 'package:flutter/material.dart';
import 'package:notesapp/constants/routes.dart';
import 'package:notesapp/services/auth/authServices.dart';
import 'package:notesapp/views/EmailVerificationView.dart';
import 'package:notesapp/views/LoginView.dart';
import 'package:notesapp/views/RegisterView.dart';
import 'dart:developer' as devtools show log;

import 'package:notesapp/views/notesView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false
      ),
      home: const HomePage(),
      routes:{
         registerRoute : (context) => const RegisterView(),
        loginRoute : (context) => const LoginView(),
        notesRoute : (context) => const NotesView(),
        verifyEmailRoute : (context) => const EmailVerificationView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

 @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
          future: authServices.firebase().initialize(),
                    builder: (context, snapshot){
                      switch (snapshot.connectionState){
                        case ConnectionState.done:
                        
                      //   print(FirebaseAuth.instance.currentUser);
                     final user  = authServices.firebase().currentUser;
                     print(user);
                     if(user != null){
                      if(user.isEmailVerified){
                        // print('email is verified');
                        devtools.log('email is verified');
                        return NotesView();
                      }
                      else{
                        const EmailVerificationView();
                      }
                      }else{
                        return const LoginView();
                      }
                      return const Text('done');
                      
                        default:
                        return const CircularProgressIndicator();
                     }
                    
                    },
          
        );
  }

}