import 'package:meta/meta.dart';
import 'package:pokeep/models/account/person.dart';

class Member implements Person {
  String key;
  @override
  String iconUrl;
  @override
  String name;
  String mail;
  @override
  String id;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mail': mail,
        'icon_url': iconUrl,
      };

  @override
  bool operator ==(o) => o is Member && o.id == this.id;

  @override
  int get hashCode => super.hashCode;

  Member({
    @required this.id,
    @required this.name,
    @required this.mail,
    @required this.iconUrl,
  });

  Member.fromJson(this.key, Map<String, dynamic> value) {
    this.id = value['id'];
    this.name = value['name'];
    this.mail = value['mail'];
    this.iconUrl = value['iconUrl'];
  }
}
