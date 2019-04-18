import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:flutter/material.dart';
import 'package:pokeep/blocs/me_bloc/bloc.dart';
import 'package:pokeep/blocs/me_bloc/provider.dart';
import 'package:pokeep/models/account/me.dart';
import 'package:pokeep/view/pages/chat_groups/main.dart';
import 'package:pokeep/view/pages/home/main.dart';

class _Pages {
  final String value;

  _Pages._(this.value);

  static final home = _Pages._('home');
  static final chatGroups = _Pages._('chatGroups');

  static Widget widget(int index) {
    switch (index) {
      case 0:
        return Home();
        break;
      case 1:
        return ChatGroupsPage();
        break;
    }
    return null;
  }

  static String title(int index) {
    switch (index) {
      case 0:
        return 'Home';
        break;
      case 1:
        return 'Chat Groups';
        break;
    }
    return null;
  }
}

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final MeBloc meBloc = MeBlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_Pages.title(_index)),
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
      bottomNavigationBar: bmnav.BottomNav(
        onTap: (int index) {
          setState(() {
            _index = index;
          });
        },
        items: [
          bmnav.BottomNavItem(Icons.home),
          bmnav.BottomNavItem(Icons.chat_bubble_outline),
        ],
      ),
      body: _Pages.widget(_index),
    );
  }
}
