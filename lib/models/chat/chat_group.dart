class ChatGroup {
  String key;
  String name;

  ChatGroup(this.name);

  ChatGroup.fromJson(this.key, Map<String, dynamic> value) {
    name = value['name'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
