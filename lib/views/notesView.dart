import 'package:flutter/material.dart';
import 'package:notesapp/constants/routes.dart';
import 'package:notesapp/enums/menuactions.dart';
import 'package:notesapp/services/auth/authServices.dart';
import 'dart:developer' as devtools show log;

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
                  // await FirebaseAuth.instance.signOut();
                  await authServices.firebase().logout() ;
                  
                  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, 
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


