import 'package:pokeep/models/account/user.dart';

class Message {
  final User sendUser;
  final DateTime sendDate;
  final String image;

  bool hasImage() => image != null;

  Message({this.sendUser, this.sendDate}) : image = null;

  Message.withImage({this.sendUser, this.sendDate, this.image});
}
