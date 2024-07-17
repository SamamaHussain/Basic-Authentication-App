import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/firebase_options.dart';
import 'package:notesapp/views/EmailVerificationView.dart';
import 'package:notesapp/views/LoginView.dart';
import 'package:notesapp/views/RegisterView.dart';
import 'dart:developer' as devtools show log;

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
                     print(user);
                     if(user != null){
                      if(user.emailVerified){
                        print('email is verified');
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
          
        ),
      );
  }

}

enum MenuAction {logout}


class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesView();
}

class _NotesView extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            devtools.log(value.toString());
            switch (value) {
              
              case MenuAction.logout:
                final shouldLogout= await showLogoutDialog(context);
                if (shouldLogout){
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil('/login/', 
                  (_) => false );
                }
            }
            
          },
          itemBuilder: (context) {
           return const[
            const PopupMenuItem<MenuAction>(
            value: MenuAction.logout, 
            child: Text('Logout'),
            ),
            ];
          },
          )
        ],
      ),
      body: const Text("Hellooz"),
    );
  }
}
  

Future<bool> showLogoutDialog(BuildContext context){
  return showDialog<bool>(
    context: context,
   builder: (context) {
    return AlertDialog(
      title: const Text('Sign Out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context).pop(false);
        }, child: const Text('Cancel')),
        TextButton(onPressed: () {
          Navigator.of(context).pop(true);
        }, child: const Text('Log out'))
    ],);
     
   },
   ).then((value) => value ?? false);
}




