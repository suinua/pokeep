import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:pokeep/blocs/me_bloc/bloc.dart';
import 'package:pokeep/blocs/me_bloc/provider.dart';
import 'package:pokeep/view/pages/home/main.dart';
import 'package:pokeep/view/pages/sign_in/main.dart';

import 'package:pokeep/models/account/me.dart';

import 'blocs/joining_chat_groups_blocs/bloc.dart';
import 'blocs/joining_chat_groups_blocs/chat_group_bloc/bloc.dart';
import 'blocs/joining_chat_groups_blocs/chat_group_bloc/provider.dart';
import 'blocs/my_items_bloc/bloc.dart';
import 'blocs/my_items_bloc/provider.dart';

void main() => runApp(BlocProviderTree(
      blocProviders: [
        MeBlocProvider(value: MeBloc()),
        MyItemsBlocProvider(value: MyItemsBloc()),
        //chat group
        ChatGroupBlocProvider(value: ChatGroupBloc()),
      ],
      child: Pokeep(),
    ));

class Pokeep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MeBloc meBloc = MeBlocProvider.of(context);
    final MyItemsBloc myItemsBloc = MyItemsBlocProvider.of(context);

    meBloc.me.listen((me){
      myItemsBloc.joiningChatGroupsBloc = JoiningChatGroupsBloc(me.id);
    });

    return MaterialApp(
      home: StreamBuilder<Me>(
        stream: meBloc.me,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return SignInPage();
          return Home();
        }
      ),
    );
  }
}
