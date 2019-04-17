import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:pokeep/models/chat/chat_group.dart';

typedef void OnChatGroupAdded(ChatGroup chatGroup);
typedef void OnChatGroupDeleted(ChatGroup chatGroup);

class ChatGroupsRepository {
  DatabaseReference _chatGroupsRef;

  final OnChatGroupAdded onChatGroupAdded;
  final OnChatGroupDeleted onChatGroupDeleted;

  StreamSubscription<Event> _onChatGroupAddedListener;
  StreamSubscription<Event> _onChatGroupRemovedListener;

  ChatGroupsRepository({
    @required this.onChatGroupAdded,
    @required this.onChatGroupDeleted,
  }) {
    _chatGroupsRef = FirebaseDatabase.instance.reference().child('chat_groups');
    _onChatGroupAddedListener = _chatGroupsRef.onChildAdded.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onChatGroupAdded(ChatGroup.fromJson(event.snapshot.key, value));
    });

    _onChatGroupRemovedListener = _chatGroupsRef.onChildRemoved.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onChatGroupDeleted(ChatGroup.fromJson(event.snapshot.key, value));
    });
  }

  void addGroup(ChatGroup chatGroup) {
    _chatGroupsRef.push().set(chatGroup.toJson());
  }

  void deleteGroup(ChatGroup chatGroup) {
    _chatGroupsRef.child(chatGroup.key).remove();
  }

  void dispose() {
    _onChatGroupAddedListener.cancel();
    _onChatGroupRemovedListener.cancel();
  }
}
