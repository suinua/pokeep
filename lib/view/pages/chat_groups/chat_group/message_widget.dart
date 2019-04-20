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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: Image.network(message.owner.iconUrl),
              ),
            ),
            Text(
              message.owner.name,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Opacity(
              opacity: 0.0,
              child: CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60.0),
                  child: Image.network(message.owner.iconUrl),
                ),
              ),
            ),
            Flexible(
              child: Text(
                message.text,
                maxLines: 100,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
