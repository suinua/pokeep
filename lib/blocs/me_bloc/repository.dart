import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:pokeep/models/account/me.dart';

typedef OnUpdateJoiningGroups(List<String> groupKeys);

class MeRepository {
  DatabaseReference _joiningGroupsRef;
  String id;

  final OnUpdateJoiningGroups onUpdateJoiningGroups;

  static void signIn(Me me) {
    final usersRef =
        FirebaseDatabase.instance.reference().child('users').child(me.id);
    usersRef.set(me.toJson());
  }

  MeRepository(this.id, {@required this.onUpdateJoiningGroups}) {
    _joiningGroupsRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(id)
        .child('joining_groups');

    _joiningGroupsRef.onValue.listen((event) {
      this.onUpdateJoiningGroups(event.snapshot.value);
    });
  }
}
