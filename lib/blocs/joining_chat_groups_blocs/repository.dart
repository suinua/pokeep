import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:pokeep/models/chat/chat_group.dart';

typedef void OnJoinChatGroup(ChatGroup chatGroups);
typedef void OnLeftChatGroup(ChatGroup chatGroups);

class JoiningChatGroupsRepository {
  DatabaseReference _joiningGroupKeys;

  final OnJoinChatGroup onJoinChatGroup;
  final OnLeftChatGroup onLeftChatGroup;

  JoiningChatGroupsRepository(String userId,
      {@required this.onJoinChatGroup, @required this.onLeftChatGroup}) {
    assert(userId != null);
    assert(onJoinChatGroup != null);
    assert(onLeftChatGroup != null);
    _joiningGroupKeys = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(userId)
        .child('joining_groups');

    _joiningGroupKeys.onChildAdded.listen((event) {
      final String chatGroupKey = event.snapshot.value;

      FirebaseDatabase.instance
          .reference()
          .child('chat_groups')
          .child(chatGroupKey)
          .once()
          .then((value) {
        onJoinChatGroup(ChatGroup.fromJson(
            chatGroupKey, Map<String, dynamic>.from(value.value)));
      });
    });

    _joiningGroupKeys.onChildRemoved.listen((event) {
      final String chatGroupKey = event.snapshot.value;
      FirebaseDatabase.instance
          .reference()
          .child('chat_groups')
          .child(chatGroupKey)
          .once()
          .then((value) {
        onLeftChatGroup(ChatGroup.fromJson(
            chatGroupKey, Map<String, dynamic>.from(value.value)));
      });
    });
  }

  void join(String groupKey) {
    _joiningGroupKeys.push().set(groupKey);
  }

  void left(String groupKey) {
    _joiningGroupKeys.child(groupKey).remove();
  }
}
