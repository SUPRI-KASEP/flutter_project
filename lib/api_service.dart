import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = "https://reqres.in/api";

  // LOGIN
  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"email": email, "password": password}),
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['token'];
    } else {
      final error = json.decode(response.body);
      throw Exception(error["error"] ?? "Login gagal");
    }
  }

  // GET USER PROFILE
  Future<Map<String, dynamic>> getUserProfile(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception("Gagal mengambil data user");
    }
  }
}
