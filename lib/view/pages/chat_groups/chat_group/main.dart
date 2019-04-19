import 'package:flutter/material.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/chat_group_bloc/bloc.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/chat_group_bloc/provider.dart';
import 'package:pokeep/models/chat/chat_group.dart';
import 'package:pokeep/models/chat/message.dart';

class ChatGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChatGroupBloc chatGroupBloc = ChatGroupBlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: StreamBuilder<ChatGroup>(
            stream: chatGroupBloc.getChatGroup,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              return Text(snapshot.data.name);
            }),
      ),
      body: StreamBuilder<ChatGroup>(
          stream: chatGroupBloc.getChatGroup,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            return StreamBuilder<List<Message>>(
                stream: snapshot.data.messagesBloc.getMessages,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();
                  return _buildMessages(snapshot.data);
                });
          }),
    );
  }

  Widget _buildMessages(List<Message> messages) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (_, int index) {

      },
    );
  }
}
