import 'package:pokeep/models/user.dart';

class Me implements User {
  @override
  final String id;
  @override
  String name;
  String mail;
  @override
  String iconUrl;

  Me({
    this.id,
    this.name,
    this.mail,
  });
}
