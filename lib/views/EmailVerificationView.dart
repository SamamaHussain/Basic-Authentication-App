import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
            const Text('Please check your email inbox'),
            TextButton(onPressed: () async{
              final user =FirebaseAuth.instance.currentUser;
        
              await user?.sendEmailVerification();
            }, child: const Text("Send Email Verifaction Code"))
          ],
          ),
      );
    }
  }