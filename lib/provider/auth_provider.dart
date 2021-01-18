import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chito_shopping/exception/auth_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'API.dart';

class AuthProvider with ChangeNotifier {
  String _userId;
  String _authToken;
  DateTime _expiryDate;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Timer _authTimer;

  // get if is authenticated
  bool get isAuth {
    return _authToken != null;
  }

  // get token for apis
  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _authToken != null) {
      return _authToken;
    }
    return null;
  }

  // get userid
  String get userId {
    return _userId;
  }

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
      }
      //get user id and get auth token
      _userId = response.user.uid;
      final idTokenResult = await _firebaseAuth.currentUser.getIdTokenResult();
      _authToken = idTokenResult.token;
      _expiryDate = DateTime.now()
          .add(Duration(hours: idTokenResult.expirationTime.hour));

      //auto logout if token expired
      _autoLogout();
      notifyListeners();

      //get user data if its sign in
      String profileURL = "";
      if (type == "signIn") {
        final extractedData = await _getUserData(_userId);
        profileURL = extractedData["profileURL"];
        username = extractedData["username"];
      } else {
        await _addNewUser(response.user.uid, username, email);
      }
      //save to shared prefs
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _authToken,
        "userId": _userId,
        "expiryDate": _expiryDate.toIso8601String(),
        "email": email,
        "username": username,
      });
      prefs.setString("userData", userData);
      prefs.setString("profileURL", profileURL);
    } catch (error) {
      print(error);
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
        "username": username,
        "email": email,
        "profileURL": "",
      };
      final response = await http.put(
          API.users + "$userId.json" + "?auth=$_authToken",
          body: json.encode(addUser));
      print(response.body);
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  // create new user in database
  Future<Map<String, dynamic>> _getUserData(String userId) async {
    try {
      final response =
          await http.get(API.users + "$userId.json" + "?auth=$_authToken");
      print(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      return extractedData;
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
      if (_authTimer != null) {
        _authTimer.cancel();
        _authTimer = null;
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await _firebaseAuth.signOut();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // auto logout user
  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    final timeToExpire = _expiryDate.difference(DateTime.now()).inHours;
    _authTimer = Timer(Duration(hours: timeToExpire), logout);
  }

  // auto login user
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString("userData")) as Map<String, Object>;
    print("the extractedData is $extractedData");

    final expiryDate = DateTime.parse(extractedData["expiryDate"]);
    print("the expiryDate is $expiryDate");
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    // auto login start
    _authToken = extractedData['token'];
    _expiryDate = expiryDate;
    _userId = extractedData["userId"];

    // start auto logout again for new timer
    notifyListeners();
    _autoLogout();
    return true;
  }

  // Upload product photo to firebase
  Future<void> uploadProductPhoto(File imageFile) async {
    try {
      String imageFileName = imageFile.path.split('/').last;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('users/$_userId/$imageFileName');

      UploadTask uploadTask = storageRef.putFile(imageFile);
      String imageUrl = await (await uploadTask).ref.getDownloadURL();
      await _addPhotoToDB(imageUrl);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("profileURL", imageUrl);
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  // create new user in database
  Future<void> _addPhotoToDB(String imageURL) async {
    try {
      final response = await http.put(API.users + "$userId.json",
          body: json.encode({
            "profileURL": imageURL,
          }));
      print(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      return extractedData;
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
