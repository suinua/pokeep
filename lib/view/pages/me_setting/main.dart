import 'package:flutter/material.dart';
import 'package:pokeep/blocs/me_bloc/bloc.dart';
import 'package:pokeep/blocs/me_bloc/provider.dart';
import 'package:pokeep/models/account/me.dart';
import 'package:pokeep/view/pages/me_setting/rename.dart';

class MeSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MeBloc meBloc = MeBlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Setting'),
      ),
      body: StreamBuilder<Me>(
          stream: meBloc.me,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            final Me me = snapshot.data;

            return Column(
              children: <Widget>[
                ListTile(
                  title: Text('User Name'),
                  subtitle: Text(me.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MeRenamePage(me.name),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('Mail Adress'),
                  subtitle: Text(me.mail),
                  onTap: () {},
                )
              ],
            );
          }),
    );
  }
}
