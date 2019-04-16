import 'package:meta/meta.dart';
import 'package:pokeep/models/account/person.dart';

class Me implements Person {
  @override
  final String id;
  @override
  String name;
  String mail;
  @override
  String iconUrl;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return null;
  }

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
}
