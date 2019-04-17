import 'package:flutter/material.dart';
import 'package:pokeep/models/chat/chat_group.dart';

class ChatGroupWidget extends StatelessWidget {
  final ChatGroup chatGroup;

  ChatGroupWidget({Key key, @required this.chatGroup}) : super(key: key) {
    assert(chatGroup != null);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(chatGroup.name),
    );
  }
}
