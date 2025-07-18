import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/klinik.dart';

class ApiService {
  static const String baseUrl = 'http://10.126.97.137:8000/api/klinik'; // Ganti dengan URL API kamu

  Future<List<Klinik>> fetchKliniks() async {
    final response = await http.get(Uri.parse('$baseUrl/'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Klinik.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load kliniks');
    }
  }

  Future<Klinik> fetchKlinik(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Klinik.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load klinik');
    }
  }

  Future<void> createKlinik(Klinik klinik) async {
    await http.post(
      Uri.parse('$baseUrl/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(klinik.toJson()),
    );
  }

  Future<void> updateKlinik(int id, Klinik klinik) async {
    await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(klinik.toJson()),
    );
  }

  Future<void> deleteKlinik(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}