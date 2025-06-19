class TodoModel{
  final int id;
  final String name;
  final String description;
  final bool is_done;

  TodoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.is_done,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      is_done: json['is_done'] as bool,
    );
  }

  // Method to convert TodoModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'is_done': is_done,
    };
  }
}