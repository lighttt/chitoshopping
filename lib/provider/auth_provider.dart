import 'dart:convert';

import 'package:chito_shopping/exception/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'API.dart';

class AuthProvider with ChangeNotifier {
  String _userId;
  String _authToken;
  DateTime _expiryDate;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// sign in user with firebase
  Future<void> _authenticate(
      String username, String email, String password, String type) async {
    try {
      var response;
      if (type == "signIn") {
        response = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        response = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        await _addNewUser(response.user.uid, username, email);
      }
      print(response.user.uid);
      _userId = response.user.uid;
      final idTokenResult = await _firebaseAuth.currentUser.getIdTokenResult();
      print(idTokenResult.token);
    } catch (error) {
      AuthResultStatus status = AuthResultException.handleException(error);
      String message = AuthResultException.generatedExceptionMessage(status);
      throw message;
    }
  }

  /// sign in user with firebase
  Future<void> signIn(String email, String password) async {
    return _authenticate("", email, password, "signIn");
  }

  /// sign in user with firebase
  Future<void> signUp(String username, String email, String password) async {
    return _authenticate(username, email, password, "signUp");
  }

  // create new user in database
  Future<void> _addNewUser(String userId, String username, String email) async {
    try {
      final addUser = {
        "id": userId,
        "username": username,
        "email": email,
        "profileURL": "",
      };
      final response = await http.post(API.users, body: json.encode(addUser));
      print(response.body);
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  //logout user
  Future<void> logout() async {
    try {
      _authToken = null;
      _userId = null;
      _expiryDate = null;
      await _firebaseAuth.signOut();
    } catch (error) {
      throw error;
    }
  }
}
