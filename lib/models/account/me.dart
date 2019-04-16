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

  Me({
    @required
    this.id,
    @required
    this.name,
    @required
    this.mail,
    @required
    this.iconUrl,
  });
}
