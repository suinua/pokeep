import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/bloc.dart';

class ChatGroupsBlocProvider extends BlocProvider<ChatGroupsBloc> {
  ChatGroupsBlocProvider({
    @required ChatGroupsBloc value,
  }) : super(
    creator: (context, _bag) {
      assert(context != null);
      return value;
    },
  );

  ChatGroupsBlocProvider.fromBlocContext({
    @required BuildContext context,
    @required Widget child,
  }) : super.fromBlocContext(
    child: child,
    context: context,
  );

  static ChatGroupsBloc of(BuildContext context) => BlocProvider.of(context);
}
