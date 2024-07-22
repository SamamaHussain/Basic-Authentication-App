import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/constants/routes.dart';

class EmailVerificationView extends StatefulWidget {
    const EmailVerificationView({super.key});

    @override
    State<EmailVerificationView> createState() => _EmailVerificationViewState();
  }

  class _EmailVerificationViewState extends State<EmailVerificationView> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Email Verification',
          ),
        ),
        body: Column(children: [
          const Text('An Email has been sent to your inbox, open it to verify your account.'),
            const Text('If you have not recieved an email yet, click the below buuton.'),
            TextButton(onPressed: () async{
              final user =FirebaseAuth.instance.currentUser;
        
              await user?.sendEmailVerification();
            }, child: const Text("Send Email Verifaction Code")),
          TextButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
          }, child: const Text('Restart'))
          
          ],
          
          ),
      );
    }
  }