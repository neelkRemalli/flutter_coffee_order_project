import 'package:brew_crew/model/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

// Create user Obj from firebase

  UserAuth? _userFromFirebaseUser(User? user) {
    return user != null ? UserAuth(uid: user.uid) : null;
  }

// Stream
  Stream<UserAuth?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
    // return _auth
    //     .authStateChanges()
    //     .map((User? user) => _userFromFirebaseUser(user));
  }

// Signin anonymous Authentication
  Future signInAnon() async {
    try {
      UserCredential detail = await _auth.signInAnonymously();
      User? user = detail.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential detail = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = detail.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential detail = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = detail.user;

      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'abo new order', 100);
          
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
