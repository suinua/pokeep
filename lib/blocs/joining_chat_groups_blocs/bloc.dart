import 'package:bloc_provider/bloc_provider.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/repository.dart';
import 'package:pokeep/models/chat/chat_group.dart';
import 'package:rxdart/rxdart.dart';

class ChatGroupsBloc extends Bloc {
  ChatGroupsRepository _repository;
  List<ChatGroup> _chatGroups = <ChatGroup>[];

  BehaviorSubject<List<ChatGroup>> _chatGroupsController =
      BehaviorSubject<List<ChatGroup>>();

  Sink<List<ChatGroup>> get _setGroups => _chatGroupsController.sink;

  Stream<List<ChatGroup>> get getChatGroups => _chatGroupsController.stream;

  BehaviorSubject<ChatGroup> _joinGroupController = BehaviorSubject<ChatGroup>();
  BehaviorSubject<ChatGroup> _leftGroupController =
      BehaviorSubject<ChatGroup>();

  ChatGroupsBloc() {
    _repository = ChatGroupsRepository(
      onChatGroupAdded: (ChatGroup chatGroup) {
        _chatGroups.add(chatGroup);
        _setGroups.add(_chatGroups);
      },
      onChatGroupDeleted: (ChatGroup chatGroup) {
        _chatGroups.add(chatGroup);
        _setGroups.add(_chatGroups);
      },
    );
    _joinGroupController.stream.listen((ChatGroup chatGroup) {
      _repository.addGroup(chatGroup);
    });
    _leftGroupController.stream.listen((ChatGroup chatGroup) {
      _repository.deleteGroup(chatGroup);
    });
  }

  @override
  void dispose() async {
    await _chatGroupsController.close();
    await _joinGroupController.close();
    await _leftGroupController.close();
  }
}
