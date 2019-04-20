import 'package:flutter/material.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/chat_group_bloc/bloc.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/chat_group_bloc/provider.dart';
import 'package:pokeep/models/account/person.dart';
import 'package:pokeep/models/chat/chat_group.dart';
import 'package:pokeep/models/chat/message.dart';

class SendMessageWidget extends StatefulWidget {
  final Person sendUser;

  SendMessageWidget({Key key, @required this.sendUser}) : super(key: key) {
    assert(sendUser != null);
  }

  @override
  _SendMessageWidgetState createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  String _messageText = '';

  @override
  Widget build(BuildContext context) {
    final ChatGroupBloc chatGroupBloc = ChatGroupBlocProvider.of(context);

    return BottomAppBar(
      child: Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery
            .of(context)
            .viewInsets
            .bottom),
        child: StreamBuilder<ChatGroup>(
            stream: chatGroupBloc.getChatGroup,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              return Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _messageText = value;
                          });
                        }
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      snapshot?.data?.messagesBloc?.send?.add(
                        Message(
                          _messageText,
                          owner: widget.sendUser,
                          sendDate: DateTime.now(),
                        ),
                      );
                    },
                  ),
                ],
              );
            }),
      ),
    );
  }
}
