import 'package:flutter/material.dart';
import 'package:pokeep/blocs/me_bloc/bloc.dart';
import 'package:pokeep/blocs/me_bloc/provider.dart';
import 'package:pokeep/models/account/me.dart';
import 'package:pokeep/models/chat/chat_group.dart';
import 'package:pokeep/view/pages/chat_groups/chat_group_widget.dart';

class ChatGroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MeBloc meBloc = MeBlocProvider.of(context);

    return StreamBuilder<Me>(
        stream: meBloc.me,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return StreamBuilder<List<ChatGroup>>(
            stream: snapshot.data.joiningChatGroupsBloc.getGroups,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              final List<ChatGroup> chatGroups = snapshot.data;
              return _buildChatGroups(chatGroups);
            },
          );
        });
  }

  Widget _buildChatGroups(List<ChatGroup> chatGroups) {
    return ListView.separated(
      itemBuilder: (_, int index) {
        return ChatGroupWidget(chatGroup: chatGroups[index]);
      },
      separatorBuilder: (_, _i) => Divider(),
      itemCount: chatGroups.length,
    );
  }
}
