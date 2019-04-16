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
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return null;
  }

  @override
  bool operator ==(o) => o is User && o.id == this.id;

  @override
  int get hashCode => super.hashCode;
}
