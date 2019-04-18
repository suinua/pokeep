import 'package:flutter/material.dart';
import 'package:pokeep/blocs/joining_chat_groups_blocs/bloc.dart';
import 'package:pokeep/blocs/me_bloc/bloc.dart';
import 'package:pokeep/blocs/me_bloc/provider.dart';
import 'package:pokeep/blocs/my_items_bloc/bloc.dart';
import 'package:pokeep/blocs/my_items_bloc/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MeBloc meBloc = MeBlocProvider.of(context);
    final MyItemsBloc myItemsBloc = MyItemsBlocProvider.of(context);

    meBloc.me.listen((me) {
      myItemsBloc.joiningChatGroupsBloc = JoiningChatGroupsBloc(me.id);
      Navigator.pushReplacementNamed(context, '/initial_page');
    });

    return RaisedButton(
      onPressed: () {
        meBloc.signIn.add(null);
      },
      child: const Text('SignIn'),
    );
  }
}
