import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/resource_model.dart';

class ResourceNotifier extends StateNotifier<List<ResourceModel>> {
  ResourceNotifier() : super([]);

  void addResource(String name) {
    final newResource = ResourceModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      type: 'Document',
      timestamp: DateTime.now(),
    );
    state = [...state, newResource];
  }

  void removeResource(String id) {
    state = state.where((r) => r.id != id).toList();
  }
}

final resourceProvider = StateNotifierProvider<ResourceNotifier, List<ResourceModel>>((ref) {
  return ResourceNotifier();
});
