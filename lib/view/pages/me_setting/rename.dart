import 'package:flutter/material.dart';
import 'package:pokeep/blocs/me_bloc/bloc.dart';
import 'package:pokeep/blocs/me_bloc/provider.dart';

class MeRenamePage extends StatefulWidget {
  final String currentName;

  const MeRenamePage(
    this.currentName, {
    Key key,
  }) : super(key: key);

  @override
  _MeRenamePageState createState() => _MeRenamePageState();
}

class _MeRenamePageState extends State<MeRenamePage> {
  TextEditingController _newNameController;
  String _newName = '';

  @override
  void initState() {
    _newNameController = TextEditingController(text: widget.currentName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MeBloc meBloc = MeBlocProvider.of(context);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  onPressed: _newName == widget.currentName
                      ? null
                      : () {
                          meBloc.rename.add(_newName);
                        },
                  child: const Text('Save'),
                )
              ],
            )),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Rename'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: const Text('Current name'),
            subtitle: Text(widget.currentName),
          ),
          Divider(),
          Text(
            'New name',
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: TextField(
              controller: _newNameController,
              onChanged: (value) {
                setState(() {
                  _newName = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
