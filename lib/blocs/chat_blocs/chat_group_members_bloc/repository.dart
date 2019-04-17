import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:pokeep/models/account/me.dart';
import 'package:pokeep/models/account/member.dart';
import 'package:pokeep/models/account/user.dart';

typedef void OnMemberJoined(Member message);
typedef void OnMemberLeft(Member message);

class ChatGroupMembersRepository {
  DatabaseReference _membersRef;
  final String groupKey;
  final OnMemberJoined onMemberJoined;
  final OnMemberLeft onMemberLeft;

  StreamSubscription<Event> _onUserJoinedListener;
  StreamSubscription<Event> _onUserLeftListener;

  ChatGroupMembersRepository({
    @required this.groupKey,
    @required this.onMemberJoined,
    @required this.onMemberLeft,
  }) {
    assert(groupKey != null);
    _membersRef = FirebaseDatabase.instance
        .reference()
        .child('chat_groups')
        .child(groupKey)
        .child('members');

    _onUserJoinedListener = _membersRef.onChildAdded.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onMemberJoined(Member.fromJson(event.snapshot.key, value));
    });

    _onUserLeftListener = _membersRef.onChildRemoved.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onMemberLeft(Member.fromJson(event.snapshot.key, value));
    });
  }

  void join(User user) {
    _membersRef.push().set(user.toJson());
  }

  void leave(Member member) {
    _membersRef.child(member.key).remove();
  }

  void dispose() {
    _onUserJoinedListener.cancel();
    _onUserLeftListener.cancel();
  }
}
