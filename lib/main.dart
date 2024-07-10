import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/firebase_options.dart';
import 'package:notesapp/views/EmailVerificationView.dart';
import 'package:notesapp/views/LoginView.dart';
import 'package:notesapp/views/RegisterView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 102, 57, 180)),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes:{
        '/register/' : (context) => const RegisterView(),
        '/login/' : (context) => const LoginView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

 @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),

        child: FutureBuilder(
          future: Firebase.initializeApp( 
            options: DefaultFirebaseOptions.currentPlatform,
                    ),
                    builder: (context, snapshot){
                      switch (snapshot.connectionState){
                        case ConnectionState.done:
                        
                      //   print(FirebaseAuth.instance.currentUser);
                     User? user  = FirebaseAuth.instance.currentUser;
                     if(user != null){
                      if(user.emailVerified){
                        print('email is verified');
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
          
        ),
      );
  }

}

  




