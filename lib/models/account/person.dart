abstract class Person {
  final String id;
  String name;
  String iconUrl;

  Map<String, dynamic> toJson() {}

  @override
  bool operator ==(o) => o is Person && o.id == this.id;

  @override
  int get hashCode => super.hashCode;

  Person({
    this.id,
    this.name,
    this.iconUrl,
  });
}
