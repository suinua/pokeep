import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

typedef void OnNameChanged(String name);

class ChatGroupRepository {
  DatabaseReference _chatGroupNameRef;

  final String groupKey;
  final OnNameChanged onNameChanged;

  StreamSubscription<Event> _onNameChangedListener;

  ChatGroupRepository({
    @required this.groupKey,
    @required this.onNameChanged,
  }) {
    _chatGroupNameRef = FirebaseDatabase.instance
        .reference()
        .child('chat_groups')
        .child(groupKey)
        .child('name');

    _onNameChangedListener = _chatGroupNameRef.onValue.listen((event) {
      onNameChanged(event.snapshot.value);
    });
  }

  void updateName(String name) => _chatGroupNameRef.set(name);

  void dispose() {
    _onNameChangedListener.cancel();
  }
}
