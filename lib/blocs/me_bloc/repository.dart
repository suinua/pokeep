import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:pokeep/models/account/me.dart';

typedef OnUpdateAffiliationGroups(List<String> groupKeys);

class MeRepository {
  DatabaseReference _affiliationGroupsRef;
  String id;

  final OnUpdateAffiliationGroups onUpdateAffiliationGroups;

  static void signIn(Me me) {
    final usersRef =
        FirebaseDatabase.instance.reference().child('users').child(me.id);
    usersRef.set(me.toJson());
  }

  MeRepository(this.id, {@required this.onUpdateAffiliationGroups}) {
    _affiliationGroupsRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(id)
        .child('affiliation_groups');

    _affiliationGroupsRef.onValue.listen((event) {
      this.onUpdateAffiliationGroups(event.snapshot.value);
    });
  }
}
