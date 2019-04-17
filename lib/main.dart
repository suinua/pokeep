import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:pokeep/blocs/me_bloc/bloc.dart';
import 'package:pokeep/blocs/me_bloc/provider.dart';
import 'package:pokeep/view/pages/home/main.dart';
import 'package:pokeep/view/pages/sign_in/main.dart';

import 'package:pokeep/models/account/me.dart';

import 'blocs/chat_blocs/chat_group_bloc/bloc.dart';
import 'blocs/chat_blocs/chat_group_bloc/provider.dart';
import 'blocs/chat_blocs/chat_groups_bloc/bloc.dart';
import 'blocs/chat_blocs/chat_groups_bloc/provider.dart';

void main() => runApp(BlocProviderTree(
      blocProviders: [
        MeBlocProvider(value: MeBloc()),
        //chat group
        ChatGroupsBlocProvider(value: ChatGroupsBloc()),
        ChatGroupBlocProvider(value: ChatGroupBloc()),
      ],
      child: Pokeep(),
    ));

class Pokeep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MeBloc meBloc = MeBlocProvider.of(context);

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
