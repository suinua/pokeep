import 'package:bloc_provider/bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokeep/models/account/me.dart';
import 'package:rxdart/rxdart.dart';

import 'me_repository.dart';

class MeBloc implements Bloc {
  Me _me;
  MeRepository _repository;

  BehaviorSubject<Me> _meController = BehaviorSubject<Me>();

  Sink<Me> get _setValue => _meController.sink;

  Stream<Me> get me => _meController.stream;

  BehaviorSubject<Null> _signInController = BehaviorSubject<Null>();
  BehaviorSubject<Null> _signOutController = BehaviorSubject<Null>();
  BehaviorSubject<String> _renameController = BehaviorSubject<String>();

  Sink<Null> get signIn => _signInController.sink;

  Sink<Null> get signOut => _signOutController.sink;

  Sink<String> get rename => _renameController.sink;

  GoogleSignIn _googleSignIn;
  FirebaseAuth _auth;

  void _doSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);

    final DatabaseReference meRef =
        FirebaseDatabase.instance.reference().child('users').child(user.uid);

    final _meDateOnFirebase = await meRef.once();

    if (_meDateOnFirebase == null) {
      _me = Me(
          id: user.uid,
          name: user.displayName,
          mail: user.email,
          iconUrl: user.photoUrl);
      meRef.update(_me.toJson());
    } else {
      _me = Me.fromJson(Map<String, dynamic>.from(_meDateOnFirebase.value));
    }

    _repository = MeRepository(_me.id, onRenamed: (String name) {
      _me.name = name;
    });
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
    _renameController.stream.listen((String name){
      assert(_me != null);
      _repository.rename(name);
    });
  }

  @override
  void dispose() async {
    await _meController.close();
    await _signInController.close();
    await _signOutController.close();
    await _renameController.close();
  }
}
