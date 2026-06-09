import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../core/constants.dart';

class GeminiService {
  final GenerativeModel _model = GenerativeModel(
    model: AppConstants.geminiModel,
    apiKey: AppConstants.geminiApiKey,
    generationConfig: GenerationConfig(responseMimeType: 'application/json'),
  );

  final GenerativeModel _textModel = GenerativeModel(
    model: AppConstants.geminiModel,
    apiKey: AppConstants.geminiApiKey,
    generationConfig: GenerationConfig(responseMimeType: 'text/plain'),
  );

  Future<List<dynamic>> generateSchema(String prompt) async {
    final aiPrompt = 'Generate a JSON schema for a spreadsheet based on the following description: "$prompt". The schema should be an array of objects, where each object represents a column with \n```json\n{\n  "column_name": "string",\n  "column_type": "string" // e.g., "text", "number", "date", "boolean"\n}\n```\n\nExample output:\n```json\n[\n  {"column_name": "Product Name", "column_type": "text"},\n  {"column_name": "Quantity", "column_type": "number"},\n  {"column_name": "Price", "column_type": "number"}\n]\n```\n\nOnly return the JSON array, no other text.';
    
    final response = await _model.generateContent([Content.text(aiPrompt)]);
    if (response.text == null) throw Exception('AI returned empty response');
    return jsonDecode(response.text!);
  }

  Future<Map<String, dynamic>> extractRowData(String text, List<Map<String, dynamic>> schema) async {
    final schemaColumns = schema.map((col) => col['column_name']).join(', ');
    final aiPrompt = 'Extract data from the following text based on the provided JSON schema. The schema defines the column names and types. Return the extracted data as a single JSON object where keys are column names and values are the extracted data. If a value is not found, use null. Ensure numbers are actual numbers and not strings. For boolean types, use true/false. For date types, use ISO 8601 format (YYYY-MM-DD).\n\nSchema columns: [$schemaColumns]\n\nText to extract from: "$text"';

    final response = await _model.generateContent([Content.text(aiPrompt)]);
    if (response.text == null) throw Exception('AI returned empty response');
    return jsonDecode(response.text!);
  }

  Future<String> analyzeData(List<Map<String, dynamic>> rowData, String question) async {
    final dataString = jsonEncode(rowData);
    final aiPrompt = 'Analyze the following spreadsheet data and answer the user\'s question in Burmese. The data is a JSON array of objects, where each object is a row. \n\nData: $dataString\n\nUser\'s question: "$question"';

    final response = await _textModel.generateContent([Content.text(aiPrompt)]);
    return response.text ?? 'No analysis available.';
  }
}
