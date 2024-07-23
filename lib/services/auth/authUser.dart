import 'package:firebase_auth/firebase_auth.dart' show User;

class authUser {
  final bool isEmailVerified;
  const authUser(this.isEmailVerified);

  factory authUser.fromFirebase(User user) => authUser(user.emailVerified);

}