import 'package:pokeep/blocs/joining_chat_groups_blocs/chat_group_members_bloc/bloc.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/chat_group_messages_bloc/bloc.dart';

class ChatGroup {
  String key;
  String name;

  ChatGroupMessagesBloc messagesBloc;
  ChatGroupMembersBloc membersBloc;

  ChatGroup(this.name);

  ChatGroup.fromJson(this.key, Map<String, dynamic> value) {
    this.name = value['name'];
    messagesBloc = ChatGroupMessagesBloc(this.key);
    membersBloc = ChatGroupMembersBloc(this.key);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
