import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../logic/providers/sheet_provider.dart';

class SheetTab extends ConsumerStatefulWidget {
  const SheetTab({super.key});

  @override
  ConsumerState<SheetTab> createState() => _SheetTabState();
}

class _SheetTabState extends ConsumerState<SheetTab> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sheetState = ref.watch(sheetProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Create new sheet...',
              prefixIcon: const Icon(Icons.add, color: Colors.cyan),
              suffixIcon: IconButton(
                icon: const Icon(Icons.check, color: Colors.cyan),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    ref.read(sheetProvider.notifier).createSheetFromPrompt(_controller.text);
                    _controller.clear();
                  }
                },
              ),
            ),
          ),
        ),
        if (sheetState.isLoading)
          const LinearProgressIndicator(color: Colors.cyan),
        Expanded(
          child: sheetState.allSheets.isEmpty
              ? _buildEmptyState()
              : GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: sheetState.allSheets.length,
                  itemBuilder: (context, index) {
                    final sheet = sheetState.allSheets[index];
                    final isSelected = sheetState.currentSheet?.id == sheet.id;
                    return GestureDetector(
                      onTap: () => ref.read(sheetProvider.notifier).selectSheet(sheet),
                      child: Card(
                        color: const Color(0xFF2A2F4A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected ? Colors.cyan : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.table_chart, size: 48, color: Colors.cyan),
                            const SizedBox(height: 12),
                            Text(
                              sheet.title,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
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
          Icon(Icons.description, size: 64, color: Colors.cyan.withOpacity(0.5)),
          const SizedBox(height: 16),
          const Text('No sheets yet', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
