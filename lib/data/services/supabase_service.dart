import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/sheet_model.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<SheetModel>> fetchAllSheets() async {
    final response = await _client
        .from('user_sheets')
        .select('id, title, schema')
        .order('created_at', ascending: false);
    return (response as List).map((json) => SheetModel.fromJson(json)).toList();
  }

  Future<SheetModel> createSheet(String title, List<dynamic> schema) async {
    final response = await _client.from('user_sheets').insert({
      'title': title,
      'schema': schema,
    }).select('id, title, schema').single();
    return SheetModel.fromJson(response);
  }

  Future<List<Map<String, dynamic>>> fetchSheetData(String sheetId) async {
    final response = await _client
        .from('sheet_data')
        .select('row_data')
        .eq('sheet_id', sheetId);
    return (response as List).map((row) => row['row_data'] as Map<String, dynamic>).toList();
  }

  Future<void> insertRowData(String sheetId, Map<String, dynamic> rowData) async {
    await _client.from('sheet_data').insert({
      'sheet_id': sheetId,
      'row_data': rowData,
    });
  }
}
