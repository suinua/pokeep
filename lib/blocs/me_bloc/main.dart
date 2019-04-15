import 'package:bloc_provider/bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokeep/models/me.dart';
import 'package:rxdart/rxdart.dart';

class MeBloc implements Bloc {
  Me _me;

  BehaviorSubject<Me> _meController = BehaviorSubject<Me>();

  Sink<Me> get _setValue => _meController.sink;

  Stream<Me> get me => _meController.stream;

  BehaviorSubject<Null> _signInController = BehaviorSubject<Null>();
  BehaviorSubject<Null> _signOutController = BehaviorSubject<Null>();

  Sink<Null> get signIn => _signInController.sink;

  Sink<Null> get signOut => _signOutController.sink;

  GoogleSignIn _googleSignIn;
  FirebaseAuth _auth;

  void _doSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    _me = Me(
      id: user.uid,
      name: user.displayName,
      mail: user.email,
      iconUrl: user.photoUrl
    );
    _setValue.add(_me);
  }

  void _doSignOut() {
    _auth.signOut();
    _setValue.add(null);
  }

  MeBloc() {
    _googleSignIn = GoogleSignIn();
    _auth = FirebaseAuth.instance;

    _signInController.stream.listen((_) => _doSignIn());
    _signOutController.stream.listen((_) => _doSignOut());
  }

  @override
  void dispose() async {
    await _meController.close();
    await _signInController.close();
    await _signOutController.close();
  }
}
