import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:pokeep/blocs/me_bloc/main.dart';
import 'package:pokeep/blocs/me_bloc/provider.dart';
import 'package:pokeep/view/pages/home/main.dart';
import 'package:pokeep/view/pages/sign_in/main.dart';

import 'package:pokeep/models/account/me.dart';

void main() => runApp(BlocProviderTree(
      blocProviders: [
        MeBlocProvider(value: MeBloc())
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
