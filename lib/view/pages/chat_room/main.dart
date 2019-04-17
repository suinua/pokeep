import 'package:flutter/material.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/bloc.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/provider.dart';
import 'package:pokeep/models/chat/chat_group.dart';
import 'package:pokeep/view/pages/chat_room/chat_group_widget.dart';

class ChatRoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChatGroupsBloc chatGroupsBloc = ChatGroupsBlocProvider.of(context);
    return StreamBuilder<List<ChatGroup>>(
        stream: chatGroupsBloc.getChatGroups,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          final List<ChatGroup> chatGroups = snapshot.data;
          return _buildChatGroups(chatGroups);
        });
  }

  Widget _buildChatGroups(List<ChatGroup> chatGroups) {
    return ListView.separated(
      itemBuilder: (_, int index) {
        return ChatGroupWidget(chatGroup: chatGroups[index]);
      },
      separatorBuilder: null,
      itemCount: chatGroups.length,
    );
  }
}
