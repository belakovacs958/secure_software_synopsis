import 'package:firebase_auth/firebase_auth.dart';

import '../error/exceptions.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

String getFirebaseUserUid() {
  final User? user = firebaseAuth.currentUser;
  if (user != null) {
    return user.uid;
  } else {
    throw AccessDeniedException();
  }
}
User getFirebaseUser() {
  final User? user = firebaseAuth.currentUser;
  if (user != null) {
    return user;
  } else {
    throw ServerException();
  }
}


