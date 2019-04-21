import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

typedef void OnRenamed(String name);

class MeRepository {
  DatabaseReference _nameRef;

  final String id;
  final OnRenamed onRenamed;

  MeRepository(this.id, {@required this.onRenamed}) {
    assert(id != null);
    assert(onRenamed != null);

    _nameRef = FirebaseDatabase.instance.reference().child('users').child(id).child('name');
    _nameRef.onValue.listen((event){
      onRenamed(event.snapshot.value);
    });
  }

  void rename(String name){
    _nameRef.set(name);
  }
}
