import 'package:bloc_provider/bloc_provider.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/chat_group_messages_bloc/repository.dart';
import 'package:pokeep/models/chat/message.dart';
import 'package:rxdart/rxdart.dart';

class ChatGroupMessagesBloc extends Bloc {
  ChatGroupMessagesRepository _repository;
  final String groupKey;
  List<Message> _messages = <Message>[];

  BehaviorSubject<List<Message>> _messagesController =
      BehaviorSubject<List<Message>>();

  Sink<List<Message>> get _setMessages => _messagesController.sink;

  Stream<List<Message>> get getMessages => _messagesController.stream;

  BehaviorSubject<Message> _sendMessageController = BehaviorSubject<Message>();

  Sink<Message> get send => _sendMessageController.sink;

  BehaviorSubject<Message> _deleteMessageController =
      BehaviorSubject<Message>();

  Sink<Message> get delete => _deleteMessageController.sink;

  ChatGroupMessagesBloc(this.groupKey) {
    _repository = ChatGroupMessagesRepository(
      groupKey: groupKey,
      onMessageAdded: (Message message) {
        _messages.add(message);
        _setMessages.add(_messages);
      },
      onMessageDeleted: (Message message) {
        _messages.remove(message);
        _setMessages.add(_messages);
      },
    );
    _sendMessageController.stream.listen((Message message) {
      _repository.addMessage(message);
    });
    _deleteMessageController.stream.listen((Message message) {
      _repository.deleteMessage(message);
    });
  }

  @override
  void dispose() async {
    _repository.dispose();
    await _messagesController.close();
    await _sendMessageController.close();
    await _deleteMessageController.close();
  }
}
