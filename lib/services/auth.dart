import 'package:firebase_auth/firebase_auth.dart';
import 'package:tik_clone/models/user/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Get loged user
  User? getUser(){
    return _auth.currentUser;
  }

  //Sing in email
  Future loginEmailAndPass(String email, String pass)async{
    var appUser;
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User? user = result.user;
      if(user != null){
        appUser = AppUser(userName: user.displayName!, uId: user.uid, email: email, pPic: user.photoURL ==null ? "":user.photoURL!);
      }
      return appUser;
    }catch(e){
      print(e);
      return;
    }
  }

  //register with email and pass
  Future registerWithEmailAndPassword(
      String email, String pass, String pic, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);

      User? user = result.user;

      user!.updateDisplayName(username);
      user.updatePhotoURL(pic);
      var appUser = AppUser(
          email: user.email!,
          uId: user.uid,
          userName: user.displayName == null ? "":user.displayName!,
          pPic: user.photoURL ==null ? "":user.photoURL!);
      return appUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // auth change stream
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(
          (event) => event != null
              ? AppUser(
                  userName: event.displayName == null ? "" : event.displayName!,
                  uId: event.uid,
                  email: event.email!,
                  pPic: event.photoURL == null ? "" : event.photoURL!)
              : null,
        );
  }

  //sing out
  Future singOut() async {
    _auth.signOut();
  }
}
