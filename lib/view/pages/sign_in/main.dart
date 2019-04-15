import 'package:flutter/material.dart';
import 'package:pokeep/blocs/me_bloc/main.dart';
import 'package:pokeep/blocs/me_bloc/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MeBloc meBloc = MeBlocProvider.of(context);

    return RaisedButton(
      onPressed: () {
        meBloc.signIn.add(null);
      },
      child: const Text('SignIn'),
    );
  }
}
