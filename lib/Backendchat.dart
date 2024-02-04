import "package:flutter/material.dart";
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:flutter/services.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AI {
  final storage = const FlutterSecureStorage();
  List<Map<String, String>> conversation;

  AI({required this.conversation});

  getAnswer() async {
    final token = await storage.read(key: 'auth_token');
    final String apiUrl = 'https://cheatchatapp1.onrender.com/chat';
    final Map<String, String> headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };
    String instruction = Hive.box("instruction").get("instruction").toString();
    final Map<String, dynamic> payload = {
      'messages': conversation,
      "instruction": instruction == ""
          ? "Your name is Cheatchat and you are helpful assistant."
          : instruction
    };
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(payload),
        encoding: utf8,
      );

      print(response.statusCode);

      dynamic jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      String answer = jsonData["response"]["model"];
      print("answer $answer");

      return answer;
    } catch (e) {
      print('Error: $e');
    }
  }
}
