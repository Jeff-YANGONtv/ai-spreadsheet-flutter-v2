import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sheet_provider.dart';

class ChatState {
  final String analysisResult;
  final bool isAnalyzing;

  ChatState({this.analysisResult = '', this.isAnalyzing = false});

  ChatState copyWith({String? analysisResult, bool? isAnalyzing}) {
    return ChatState(
      analysisResult: analysisResult ?? this.analysisResult,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final Ref _ref;

  ChatNotifier(this._ref) : super(ChatState());

  Future<void> askAi(String question) async {
    final sheetState = _ref.read(sheetProvider);
    if (sheetState.currentRowData.isEmpty) return;

    state = state.copyWith(isAnalyzing: true);
    try {
      final result = await _ref.read(geminiServiceProvider).analyzeData(
        sheetState.currentRowData,
        question,
      );
      state = state.copyWith(analysisResult: result, isAnalyzing: false);
    } catch (e) {
      state = state.copyWith(analysisResult: 'Error: $e', isAnalyzing: false);
    }
  }

  void clearAnalysis() {
    state = ChatState();
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier(ref);
});
