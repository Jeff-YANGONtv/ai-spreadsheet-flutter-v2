import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/sheet_model.dart';
import '../../data/services/supabase_service.dart';
import '../../data/services/gemini_service.dart';

final supabaseServiceProvider = Provider((ref) => SupabaseService());
final geminiServiceProvider = Provider((ref) => GeminiService());

class SheetState {
  final List<SheetModel> allSheets;
  final SheetModel? currentSheet;
  final List<Map<String, dynamic>> currentRowData;
  final bool isLoading;
  final String? error;

  SheetState({
    this.allSheets = const [],
    this.currentSheet,
    this.currentRowData = const [],
    this.isLoading = false,
    this.error,
  });

  SheetState copyWith({
    List<SheetModel>? allSheets,
    SheetModel? currentSheet,
    List<Map<String, dynamic>>? currentRowData,
    bool? isLoading,
    String? error,
  }) {
    return SheetState(
      allSheets: allSheets ?? this.allSheets,
      currentSheet: currentSheet ?? this.currentSheet,
      currentRowData: currentRowData ?? this.currentRowData,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class SheetNotifier extends StateNotifier<SheetState> {
  final SupabaseService _supabase;
  final GeminiService _gemini;

  SheetNotifier(this._supabase, this._gemini) : super(SheetState()) {
    refresh();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    try {
      final sheets = await _supabase.fetchAllSheets();
      state = state.copyWith(allSheets: sheets, isLoading: false);
      if (sheets.isNotEmpty && state.currentSheet == null) {
        selectSheet(sheets.first);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> selectSheet(SheetModel sheet) async {
    state = state.copyWith(currentSheet: sheet, isLoading: true);
    try {
      final data = await _supabase.fetchSheetData(sheet.id);
      state = state.copyWith(currentRowData: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> createSheetFromPrompt(String prompt) async {
    state = state.copyWith(isLoading: true);
    try {
      final schema = await _gemini.generateSchema(prompt);
      final newSheet = await _supabase.createSheet(prompt, schema);
      await refresh();
      selectSheet(newSheet);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> addRowFromPrompt(String prompt) async {
    if (state.currentSheet == null) return;
    state = state.copyWith(isLoading: true);
    try {
      final rowData = await _gemini.extractRowData(prompt, state.currentSheet!.schema);
      await _supabase.insertRowData(state.currentSheet!.id, rowData);
      await selectSheet(state.currentSheet!);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final sheetProvider = StateNotifierProvider<SheetNotifier, SheetState>((ref) {
  return SheetNotifier(
    ref.watch(supabaseServiceProvider),
    ref.watch(geminiServiceProvider),
  );
});
