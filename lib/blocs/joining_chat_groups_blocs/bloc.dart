import 'package:bloc_provider/bloc_provider.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/repository.dart';
import 'package:pokeep/models/chat/chat_group.dart';
import 'package:rxdart/rxdart.dart';

class JoiningChatGroupsBloc extends Bloc {
  JoiningChatGroupsRepository _repository;
  List<ChatGroup> _joiningGroups = <ChatGroup>[];

  BehaviorSubject<List<ChatGroup>> _groupsController =
      BehaviorSubject<List<ChatGroup>>();

  Sink<List<ChatGroup>> get _setGroups => _groupsController.sink;
  Stream<List<ChatGroup>> get getGroups => _groupsController.stream;

  BehaviorSubject<String> _joinGroupController = BehaviorSubject<String>();

  Sink<String> get join => _joinGroupController.sink;

  BehaviorSubject<String> _leaveGroupController = BehaviorSubject<String>();

  Sink<String> get lave => _leaveGroupController.sink;

  JoiningChatGroupsBloc(String userId) {
    _joinGroupController.stream.listen((String chatGroupKey) {
      _repository.join(chatGroupKey);
    });

    _leaveGroupController.stream.listen((String chatGroupKey) {
      _repository.left(chatGroupKey);
    });

    _repository = JoiningChatGroupsRepository(
      userId,
      onJoinChatGroup: (ChatGroup chatGroups) {
        _joiningGroups.add(chatGroups);
        _setGroups.add(_joiningGroups);
      },
      onLeftChatGroup: (ChatGroup chatGroups) {
        _joiningGroups.remove(chatGroups);
        _setGroups.add(_joiningGroups);
      },
    );
  }

  @override
  void dispose() async {
    await _groupsController.close();
    await _joinGroupController.close();
    await _leaveGroupController.close();
  }
}
