import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/sensor_model.dart';
import 'constants.dart';

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<SensorModel> getLatestData() async {
    final response = await _client.get(Uri.parse('${AppConstants.baseUrl}/data'));
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return SensorModel.fromJson(json);
  }

  Future<List<SensorModel>> getHistory({String range = 'hour'}) async {
    final response = await _client.get(
      Uri.parse('${AppConstants.baseUrl}/history?range=$range'),
    );
    final json = jsonDecode(response.body) as List<dynamic>;
    return json.map((e) => SensorModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> postControl(Map<String, dynamic> payload) async {
    await _post('/control', payload);
  }

  Future<void> postConfig(Map<String, dynamic> payload) async {
    await _post('/config', payload);
  }

  Future<Map<String, dynamic>> getSummary() async {
    final response = await _client.get(Uri.parse('${AppConstants.baseUrl}/summary'));
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<void> _post(String path, Map<String, dynamic> payload) async {
    await _client.post(
      Uri.parse('${AppConstants.baseUrl}$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
  }
}
