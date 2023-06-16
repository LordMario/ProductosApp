import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _urlBase = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyDecUPPBuUMBBKT1Al9BxpOJ3Bj_EPj7Nw';

  final storage = const FlutterSecureStorage();

  Future<String?> registerUser(String user, String password) async {
    final Map<String, dynamic> body = {'password': password, 'email': user};
    final url =
        Uri.https(_urlBase, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(body));

    final Map<String, dynamic> dataReponse = json.decode(resp.body);

    if (dataReponse.containsKey('idToken')) {
      await storage.write(key: 'token', value: dataReponse['idToken']);
      return null;
    }

    return dataReponse['error']['message'];
  }

  Future<String?> login(String user, String password) async {
    final Map<String, dynamic> body = {'password': password, 'email': user};
    final url = Uri.https(
        _urlBase, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(body));

    final Map<String, dynamic> dataReponse = json.decode(resp.body);

    if (dataReponse.containsKey('idToken')) {
      await storage.write(key: 'token', value: dataReponse['idToken']);
      return null;
    }

    return dataReponse['error']['message'];
  }

  Future logOut() async {
    await storage.delete(key: 'token');
    return null;
  }
}
