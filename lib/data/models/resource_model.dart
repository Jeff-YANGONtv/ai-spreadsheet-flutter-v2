class ResourceModel {
  final String id;
  final String name;
  final String type;
  final DateTime timestamp;

  ResourceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.timestamp,
  });

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
