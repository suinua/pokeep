class ChatGroup {
  String key;
  String _name;

  String get name => _name;

  ChatGroup(name): _name = name;

  ChatGroup.fromJson(this.key, Map<String, dynamic> value) {
    _name = value['name'];
  }
  Map<String, dynamic> toJson() => {
        'name': _name,
      };
}
