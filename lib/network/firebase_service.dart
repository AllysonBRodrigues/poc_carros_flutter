import 'package:carros/model/result.dart';
import 'package:carros/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService{

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<Result<FirebaseUser>> handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser fuser = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + fuser.displayName);

    final user = User(
      nome: fuser.displayName,
      login: fuser.email,
      email: fuser.email,
      urlFoto: fuser.photoUrl
    );

    user.save();

    if(fuser != null){
      return Result.success(fuser);
    } else {
      return Result.error("Erro ao logar com google");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

}