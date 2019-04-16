import 'package:meta/meta.dart';
import 'package:pokeep/models/account/person.dart';

class Message {
  String key;
  Person _owner;
  DateTime _sendDate;
  String _image;

  Person get owner => _owner;

  DateTime get sendDate => _sendDate;

  String get image => _image;

  bool hasImage() => _image != null;

  Message({
    @required
    Person owner,
    @required
    DateTime sendDate,
  })  : _owner = owner,
        _sendDate = sendDate,
        _image = null;

  Message.withImage({
    @required
    Person owner,
    @required
    DateTime sendDate,
    @required
    String image,
  })  : _owner = owner,
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
