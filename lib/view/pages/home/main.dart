import 'package:flutter/material.dart';
import 'package:pokeep/blocs/me_bloc/main.dart';
import 'package:pokeep/blocs/me_bloc/provider.dart';
import 'package:pokeep/models/me.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MeBloc meBloc = MeBlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: <Widget>[
          StreamBuilder<Me>(
              stream: meBloc.me,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();

                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: GestureDetector(
                    onTap: () {
                      //TODO : アカウント設定画面に移行
                    },
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: Image.network(snapshot.data.iconUrl),
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
      body: Container(),
    );
  }
}
