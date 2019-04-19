import 'package:flutter/material.dart';
import 'package:pokeep/models/chat/message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;

  MessageWidget({Key key, @required this.message}) : super(key: key) {
    assert(message != null);
  }

  @override
  Widget build(BuildContext context) {
    //TODO : Widgetの作成
    return Text(message.text);
  }
}
