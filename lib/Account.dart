import "dart:convert";
import "dart:io";
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:flutter/services.dart";
import "index.dart";
import 'package:dio/dio.dart';

class Account {
  final storage = const FlutterSecureStorage();

  Future<String> signup({
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      if (password != confirmPassword) {
        return 'Confirmation password not valid';
      }

      var payload = {
        'username': username,
        'password': password,
        'email': email,
      };

      final response = await http.post(
        Uri.parse('https://cheatchatapp1.onrender.com/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final data = await jsonDecode(response.body);
        final token = await data['token'];
        await storage.write(key: 'auth_token', value: token);
        await Hive.box("userInfo").put("info", data);
        // Assuming 201 status code indicates successful signup
        return 'User created';
      } else {
        throw Exception(
            'Signup failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors
      print('Signup error: $error');
      return 'Signup failed'; // Generic error message
    }
  }

  Future<String> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://cheatchatapp1.onrender.com/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = await jsonDecode(response.body);
        final token = await data['token'];
        await storage.write(key: 'auth_token', value: token);
        await Hive.box("userInfo").put("info", data); // Store the info
        print(await "User Authenticated");
        return await "User Authenticated";
      } else {
        print("Login failed!");
        return await "Login failed!";
      }
    } catch (error) {
      // Handle errors
      rethrow;
    }
  }

  Future<String> testToken() async {
    try {
      final token = await storage.read(key: 'auth_token'); // Retrieve the token
      print(token);
      if (token != null) {
        // Assuming a 200 status code indicates a valid token
        return 'User Authenticated';
      }
      // Handle invalid token cases
      else {
        return 'Token not found';
      }
    } catch (error) {
      print('Error during token verification');
      return 'User Not Authenticated'; // Treat errors as authentication failures
    }
  }

  logout() {
    final token = storage.delete(key: 'auth_token');
  }
}
