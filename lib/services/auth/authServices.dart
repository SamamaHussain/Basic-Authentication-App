import 'package:notesapp/services/auth/authProvider.dart';
import 'package:notesapp/services/auth/authUser.dart';
import 'package:notesapp/services/auth/firebaseAuthProvider.dart';

class authServices implements authProvider{
  final authProvider provider;
  authServices(this.provider);

  factory authServices.firebase() => authServices(firebaseAuthProvider());
  
  @override
  Future<authUser> createUser({required String email, required String password}) 
  => provider.createUser(email: email, password: password);
  
  @override
  // TODO: implement currentUser
  authUser? get currentUser => provider.currentUser;
  
  @override
  Future<authUser> login({required String email, required String password}) 
  => provider.login(email: email, password: password);
  
  @override
  Future<void> logout() 
 => provider.logout();
  
  @override
  Future<void> sendVerificationEmail() 
  => provider.sendVerificationEmail();
  
  @override
  Future<void> initialize() 
  => provider.initialize();

}