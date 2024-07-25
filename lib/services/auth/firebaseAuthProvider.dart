import 'package:firebase_core/firebase_core.dart';
import 'package:notesapp/firebase_options.dart';
import 'package:notesapp/services/auth/authProvider.dart';
import 'package:notesapp/services/auth/authExceptions.dart';
import 'package:notesapp/services/auth/authUser.dart';

import 'package:firebase_auth/firebase_auth.dart';

class firebaseAuthProvider implements authProvider {
  @override
  Future<authUser> createUser({required String email, required String password,}) async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    final user=currentUser;
    if(user!=null){
      return user;
    }
    else{
      throw UserNotLoggedInAuthException();
    }
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else {
        throw GenericAuthException();
      }
    }
    catch(_){
      throw GenericAuthException();
    }
    }
  @override
  // TODO: implement currentUser
  authUser? get currentUser {
    final User? user =FirebaseAuth.instance.currentUser;

    if(user!=null){
      return authUser.fromFirebase(user);
    }
    else{
      return null;
    }
  }

  @override
  Future<authUser> login({required String email, required String password})async {
     try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password,);
    final user=currentUser;
    if(user!=null){
      return user;
    }
    else{
      throw UserNotLoggedInAuthException();
    }
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    }
    catch(_){
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logout() async {
    final user=FirebaseAuth.instance.currentUser;
    if(user!=null){
      await FirebaseAuth.instance.signOut();
    }
    else{
     throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendVerificationEmail() async{
    final user=FirebaseAuth.instance.currentUser;

    if(user!=null){
      await sendVerificationEmail();
    }
    else{
      throw UserNotLoggedInAuthException();
    }
  }
  
   @override
  Future<void> initialize() async{
   await Firebase.initializeApp( 
            options: DefaultFirebaseOptions.currentPlatform,
                    );
  }

}