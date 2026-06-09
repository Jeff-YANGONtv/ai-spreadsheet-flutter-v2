import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../logic/providers/chat_provider.dart';
import '../../../logic/providers/sheet_provider.dart';
import '../../widgets/ai_analysis_card.dart';

class ChatTab extends ConsumerStatefulWidget {
  const ChatTab({super.key});

  @override
  ConsumerState<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends ConsumerState<ChatTab> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final sheetState = ref.watch(sheetProvider);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (sheetState.currentSheet != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Chip(
                      label: Text('Active Sheet: ${sheetState.currentSheet!.title}'),
                      backgroundColor: Colors.cyan.withOpacity(0.2),
                      labelStyle: const TextStyle(color: Colors.cyan),
                    ),
                  ),
                AiAnalysisCard(content: chatState.analysisResult),
                if (chatState.isAnalyzing || sheetState.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(color: Colors.cyan),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                maxLines: 3,
                minLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Ask AI or Add data...',
                  prefixIcon: Icon(Icons.chat, color: Colors.cyan),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          ref.read(chatProvider.notifier).askAi(_controller.text);
                        }
                      },
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text('Ask AI'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          ref.read(sheetProvider.notifier).addRowFromPrompt(_controller.text);
                          _controller.clear();
                        }
                      },
                      icon: const Icon(Icons.add_table_rows),
                      label: const Text('Add Data'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white10,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
