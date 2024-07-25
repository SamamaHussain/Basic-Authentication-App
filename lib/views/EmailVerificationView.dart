import 'package:flutter/material.dart';
import 'package:notesapp/constants/routes.dart';
import 'package:notesapp/services/auth/authServices.dart';

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
              await authServices.firebase().sendVerificationEmail();
            
            }, child: const Text("Send Email Verifaction Code")),
          TextButton(onPressed: () async{
            await authServices.firebase().logout();
            Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
          }, child: const Text('Restart'))
          
          ],
          
          ),
      );
    }
  }