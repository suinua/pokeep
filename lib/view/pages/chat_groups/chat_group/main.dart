import 'package:flutter/material.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/chat_group_bloc/bloc.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/chat_group_bloc/provider.dart';
import 'package:pokeep/blocs/me_bloc/bloc.dart';
import 'package:pokeep/blocs/me_bloc/provider.dart';
import 'package:pokeep/models/account/me.dart';
import 'package:pokeep/models/account/user.dart';
import 'package:pokeep/models/chat/chat_group.dart';
import 'package:pokeep/models/chat/message.dart';
import 'package:pokeep/view/pages/chat_groups/chat_group/message_widget.dart';
import 'package:pokeep/view/pages/chat_groups/chat_group/send_message_widget.dart';

class ChatGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChatGroupBloc chatGroupBloc = ChatGroupBlocProvider.of(context);
    final MeBloc meBloc = MeBlocProvider.of(context);

    return Scaffold(
      bottomNavigationBar: StreamBuilder<Me>(
          stream: meBloc.me,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            final Me me = snapshot.data;
            return SendMessageWidget(
              sendUser: User(
                id: me.id,
                name: me.name,
                mail: me.mail,
                iconUrl: me.iconUrl,
              ),
            );
          }),
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
        return MessageWidget(message: messages[index]);
      },
    );
  }
}
