import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/chat_group_bloc/bloc.dart';

class ChatGroupBlocProvider extends BlocProvider<ChatGroupBloc> {
  ChatGroupBlocProvider({
    @required ChatGroupBloc value,
  }) : super(
    creator: (context, _bag) {
      assert(context != null);
      return value;
    },
  );

  ChatGroupBlocProvider.fromBlocContext({
    @required BuildContext context,
    @required Widget child,
  }) : super.fromBlocContext(
    child: child,
    context: context,
  );

  static ChatGroupBloc of(BuildContext context) => BlocProvider.of(context);
}
