import 'package:bloc_provider/bloc_provider.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/chat_group_members_bloc/repository.dart';
import 'package:pokeep/models/account/member.dart';
import 'package:pokeep/models/account/user.dart';
import 'package:rxdart/rxdart.dart';

class ChatGroupUsersBloc extends Bloc {
  ChatGroupMembersRepository _repository;
  final String groupKey;
  List<Member> _members;

  BehaviorSubject<List<Member>> _membersController = BehaviorSubject<List<Member>>();

  Sink<List<Member>> get _setMembers => _membersController.sink;

  Stream<List<Member>> get getMembers => _membersController.stream;

  BehaviorSubject<User> _joinController = BehaviorSubject<User>();

  Stream<User> get join => _joinController.stream;

  BehaviorSubject<Member> _leaveController = BehaviorSubject<Member>();

  Stream<Member> get leave => _leaveController.stream;

  ChatGroupUsersBloc(this.groupKey) {
    _repository = ChatGroupMembersRepository(
      groupKey: groupKey,
      onMemberJoined: (Member member) {
        _members.add(member);
        _setMembers.add(_members);
      },
      onMemberLeft: (Member member) {
        _members.remove(member);
        _setMembers.add(_members);
      },
    );
    _joinController.stream.listen((User user) {
      _repository.join(user);
    });
    _leaveController.stream.listen((Member member) {
      _repository.leave(member);
    });
  }

  @override
  void dispose() async {
    _repository.dispose();
    await _membersController.close();
    await _joinController.close();
    await _leaveController.close();
  }
}
