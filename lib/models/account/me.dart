import 'package:meta/meta.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/bloc.dart';
import 'package:pokeep/models/account/person.dart';

class Me implements Person {
  @override
  String id;
  @override
  String name;
  String mail;
  @override
  String iconUrl;

  JoiningChatGroupsBloc joiningChatGroupsBloc;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mail': mail,
        'icon_url': iconUrl,
      };

  @override
  bool operator ==(o) => o is Me && o.id == this.id;

  @override
  int get hashCode => super.hashCode;

  Me({
    @required this.id,
    @required this.name,
    @required this.mail,
    @required this.iconUrl,
  }){
    joiningChatGroupsBloc = JoiningChatGroupsBloc(this.id);
  }

  Me.fromJson(Map<String, dynamic> value) {
    this.id = value['id'];
    this.name = value['name'];
    this.mail = value['mail'];
    this.iconUrl = value['icon_url'];

    joiningChatGroupsBloc = JoiningChatGroupsBloc(this.id);
  }
}
