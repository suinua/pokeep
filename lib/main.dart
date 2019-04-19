import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:pokeep/blocs/me_bloc/bloc.dart';
import 'package:pokeep/blocs/me_bloc/provider.dart';
import 'package:pokeep/view/pages/initial_page/main.dart';
import 'package:pokeep/view/pages/sign_in/main.dart';

import 'blocs/joining_chat_groups_blocs/chat_group_bloc/bloc.dart';
import 'blocs/joining_chat_groups_blocs/chat_group_bloc/provider.dart';

void main() => runApp(BlocProviderTree(
      blocProviders: [
        MeBlocProvider(value: MeBloc()),
        ChatGroupBlocProvider(value: ChatGroupBloc()),
      ],
      child: Pokeep(),
    ));

class Pokeep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (_) => _LoadScreen(),
        '/initial_page': (_) => InitialPage(),
        '/signIn': (_) => SignInPage(),
      },
    );
  }
}

class _LoadScreen extends StatefulWidget {
  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<_LoadScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3))
        .then((value) => handleTimeout());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Pokeep!'),
      ),
    );
  }

  void handleTimeout() {
    Navigator.of(context).pushReplacementNamed("/signIn");
  }
}
