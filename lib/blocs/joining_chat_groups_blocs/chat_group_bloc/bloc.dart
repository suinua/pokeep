import 'package:bloc_provider/bloc_provider.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/chat_group_bloc/repository.dart';
import 'package:pokeep/models/chat/chat_group.dart';
import 'package:rxdart/rxdart.dart';

class ChatGroupBloc extends Bloc {
  ChatGroupRepository _repository;
  ChatGroup _chatGroup;

  BehaviorSubject<ChatGroup> _chatGroupController =
      BehaviorSubject<ChatGroup>();

  Sink<ChatGroup> get _setGroup => _chatGroupController.sink;

  Stream<ChatGroup> get getChatGroup => _chatGroupController.stream;

  BehaviorSubject<ChatGroup> _replaceGroupController =
      BehaviorSubject<ChatGroup>();

  Stream<ChatGroup> get replace => _replaceGroupController.stream;

  BehaviorSubject<String> _updateNameController = BehaviorSubject<String>();

  Stream<String> get updateName => _updateNameController.stream;

  ChatGroupBloc() {
    _replaceGroupController.stream.listen((ChatGroup chatGroup) {
      _chatGroup = chatGroup;
      _setGroup.add(chatGroup);

      _repository = ChatGroupRepository(
        groupKey: _chatGroup.key,
        onNameChanged: (String name) {
          _chatGroup.name = name;
          _setGroup.add(_chatGroup);
        },
      );

      _updateNameController.stream
          .listen((String name) => _repository?.updateName(name));
    });
  }

  @override
  void dispose() async {
    _chatGroup = null;
    _repository?.dispose();

    await _chatGroupController.close();
    await _replaceGroupController.close();
    await _updateNameController.close();
  }
}
