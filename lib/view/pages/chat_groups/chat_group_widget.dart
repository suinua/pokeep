import 'package:flutter/material.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/chat_group_bloc/provider.dart';
import 'package:pokeep/models/chat/chat_group.dart';

import 'chat_group/main.dart';

class ChatGroupWidget extends StatelessWidget {
  final ChatGroup chatGroup;

  ChatGroupWidget({Key key, @required this.chatGroup}) : super(key: key) {
    assert(chatGroup != null);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ChatGroupBlocProvider.of(context).replace.add(chatGroup);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatGroupPage(),
            ));
      },
      child: ListTile(
        title: Text(chatGroup.name),
      ),
    );
  }
}
