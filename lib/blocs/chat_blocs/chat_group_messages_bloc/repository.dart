import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:pokeep/models/chat/message.dart';

typedef void OnMessageAdded(Message message);
typedef void OnMessageDeleted(Message message);

class ChatGroupMessagesRepository {
  DatabaseReference _messagesRef;

  final String groupKey;
  final OnMessageAdded onMessageAdded;
  final OnMessageDeleted onMessageDeleted;

  ChatGroupMessagesRepository({
    @required this.groupKey,
    @required this.onMessageAdded,
    @required this.onMessageDeleted,
  }) {
    assert(groupKey != null);

    _messagesRef = FirebaseDatabase.instance
        .reference()
        .child('chat_groups')
        .child(groupKey)
        .child('messages');

    _messagesRef.onChildAdded.listen((event){
      Map<String, dynamic> value =
      Map<String, dynamic>.from(event.snapshot.value);

      this.onMessageAdded(Message.fromJson(event.snapshot.key, value));
    });

    _messagesRef.onChildRemoved.listen((event){
      Map<String, dynamic> value =
      Map<String, dynamic>.from(event.snapshot.value);

      this.onMessageDeleted(Message.fromJson(event.snapshot.key, value));
    });
  }

  void addMessage(Message message){
    _messagesRef.child(message.key).remove();
  }
  void deleteMessage(Message message){
    _messagesRef.push().set(message.toJson());
  }
}
