class Todo {
  final int id;
  final String name;

  Todo({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
