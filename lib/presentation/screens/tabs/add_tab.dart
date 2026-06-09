import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../logic/providers/resource_provider.dart';

class AddTab extends ConsumerStatefulWidget {
  const AddTab({super.key});

  @override
  ConsumerState<AddTab> createState() => _AddTabState();
}

class _AddTabState extends ConsumerState<AddTab> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final resources = ref.watch(resourceProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Add resource (doc, link, text)...',
              prefixIcon: const Icon(Icons.link, color: Colors.cyan),
              suffixIcon: IconButton(
                icon: const Icon(Icons.add, color: Colors.cyan),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    ref.read(resourceProvider.notifier).addResource(_controller.text);
                    _controller.clear();
                  }
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: resources.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: resources.length,
                  itemBuilder: (context, index) {
                    final res = resources[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      color: const Color(0xFF2A2F4A),
                      child: ListTile(
                        leading: const Icon(Icons.description, color: Colors.cyan),
                        title: Text(res.name),
                        subtitle: Text(res.type),
                        trailing: IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => ref.read(resourceProvider.notifier).removeResource(res.id),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.library_books, size: 64, color: Colors.cyan.withOpacity(0.5)),
          const SizedBox(height: 16),
          const Text('No resources added', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
