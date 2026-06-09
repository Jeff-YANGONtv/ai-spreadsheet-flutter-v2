class SheetModel {
  final String id;
  final String title;
  final List<Map<String, dynamic>> schema;

  SheetModel({
    required this.id,
    required this.title,
    required this.schema,
  });

  factory SheetModel.fromJson(Map<String, dynamic> json) {
    return SheetModel(
      id: json['id'],
      title: json['title'],
      schema: List<Map<String, dynamic>>.from(json['schema']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'schema': schema,
    };
  }
}
