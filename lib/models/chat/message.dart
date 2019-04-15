import 'package:pokeep/models/account/user.dart';

class Message {
  final User owner;
  final DateTime sendDate;
  final String image;

  bool hasImage() => image != null;

  Message({this.owner, this.sendDate}) : image = null;

  Message.withImage({this.owner, this.sendDate, this.image});
}
