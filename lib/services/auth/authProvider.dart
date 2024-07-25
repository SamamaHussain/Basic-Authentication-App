import 'package:notesapp/services/auth/authUser.dart';

abstract class authProvider{
  authUser? get currentUser;

  Future<void>initialize();

  Future<authUser> login({
    required String email,
    required String password,
  });

  Future<authUser> createUser({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<void> sendVerificationEmail();
}