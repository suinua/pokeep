import 'package:meta/meta.dart';
import 'package:pokeep/models/account/person.dart';

class User implements Person {
  @override
  String id;
  @override
  String name;
  String mail;
  @override
  String iconUrl;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mail': mail,
        'icon_url': iconUrl,
      };

  @override
  bool operator ==(o) => o is User && o.id == this.id;

  @override
  int get hashCode => super.hashCode;


  User({
    @required this.id,
    @required this.name,
    @required this.mail,
    @required this.iconUrl,
  });

  User.fromJson(this.id,Map<String,dynamic> value){
    this.name = value['name'];
    this.mail = value['mail'];
    this.iconUrl = value['iconUrl'];
  }
}
