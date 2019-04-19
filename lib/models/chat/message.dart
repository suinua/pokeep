import 'package:meta/meta.dart';
import 'package:pokeep/models/account/user.dart';

class Message {
  String key;
  String _text;
  User _owner;
  DateTime _sendDate;
  String _image;

  String get text => _text;

  User get owner => _owner;

  DateTime get sendDate => _sendDate;

  String get image => _image;

  bool hasImage() => _image != null;

  Message(
    String text, {
    @required User owner,
    @required DateTime sendDate,
  })  : _owner = owner,
        _sendDate = sendDate,
        _image = null;

  Message.withImage(
    String text, {
    @required User owner,
    @required DateTime sendDate,
    @required String image,
  })  : _text = text,
        _owner = owner,
        _sendDate = sendDate,
        _image = image;

  Message.fromJson(this.key, Map<String, dynamic> value) {
    _text = value['text'];
    _owner = User.fromJson(value['owner']);
    _sendDate = DateTime.now(); //value['send_date'];
    _image = value['image'];
  }

  Map<String, dynamic> toJson() => {
        'texr': _text,
        'owner': _owner.toJson(),
        'send_date': _sendDate,
        'image': _image,
      };
}
