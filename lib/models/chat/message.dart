import 'package:meta/meta.dart';
import 'package:pokeep/models/account/person.dart';

class Message {
  String key;
  String _text;
  Person _owner;
  DateTime _sendDate;
  String _image;

  String get text => _text;

  Person get owner => _owner;

  DateTime get sendDate => _sendDate;

  String get image => _image;

  bool hasImage() => _image != null;

  Message(
    String text, {
    @required Person owner,
    @required DateTime sendDate,
  })  : _owner = owner,
        _sendDate = sendDate,
        _image = null;

  Message.withImage(
    String text, {
    @required Person owner,
    @required DateTime sendDate,
    @required String image,
  })  : _text = text,
        _owner = owner,
        _sendDate = sendDate,
        _image = image;

  Message.fromJson(this.key, Map<String, dynamic> value) {
    _owner = value['owner'];
    _sendDate = value['send_date'];
    _image = value['image'];
  }

  Map<String, dynamic> toJson() => {
        'owner': _owner,
        'send_date': _sendDate,
        'image': _image,
      };
}
