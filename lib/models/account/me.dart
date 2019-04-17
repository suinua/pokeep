import 'package:meta/meta.dart';
import 'package:pokeep/models/account/person.dart';

class Me implements Person {
  @override
  String id;
  @override
  String name;
  String mail;
  @override
  String iconUrl;

  List<String> joiningGroups = <String>[];

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mail': mail,
        'icon_url': iconUrl,
        'joining_groups': joiningGroups,
      };

  @override
  bool operator ==(o) => o is Me && o.id == this.id;

  @override
  int get hashCode => super.hashCode;

  Me({
    @required this.id,
    @required this.name,
    @required this.mail,
    @required this.iconUrl,
  });

  Me.fromJson(Map<String, dynamic> value) {
    this.id = value['id'];
    this.name = value['name'];
    this.mail = value['mail'];
    this.iconUrl = value['icon_url'];
    this.joiningGroups = value['joining_groups'];
  }
}
