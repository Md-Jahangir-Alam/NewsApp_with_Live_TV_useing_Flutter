import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class News with ChangeNotifier {

  var nowTime;

  gateTime() {
    DateTime today = new DateTime.now();
    String dateSlug =
        "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    nowTime = dateSlug;
  }

  List _sportsnews = [];

  List get sportsnews => _sportsnews;

  set sportsnews(List value) {
    _sportsnews = value;
    notifyListeners();
  }

  Future<void> sportsNews() async {
    final response = await http.get(Uri.parse("https://newsapi.org/v2/everything?q=sports&from=${nowTime}&sortBy=publishedAt&apiKey=4b786dad4c714d329a3c4b8939a890ad"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      sportsnews = data['articles'];
    }
  }

  List _bdnews = [];

  List get bdnews => _bdnews;

  set bdnews(List value) {
    _bdnews = value;
    notifyListeners();
  }

  Future<void> bdNews() async {
    final response = await http.get(Uri.parse("https://newsapi.org/v2/everything?q=bangladesh&from=${nowTime}&sortBy=publishedAt&apiKey=4b786dad4c714d329a3c4b8939a890ad"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      bdnews = data['articles'];
    }
  }

  List _worldnews = [];

  List get worldnews => _worldnews;

  set worldnews(List value) {
    _worldnews = value;
    notifyListeners();
  }

  Future<void> worldNews() async {
    final response = await http.get(Uri.parse("https://newsapi.org/v2/everything?q=International&from=${nowTime}&sortBy=publishedAt&apiKey=4b786dad4c714d329a3c4b8939a890ad"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      worldnews = data['articles'];
    }
  }

  getUid() async{
    final FirebaseAuth _auth =await FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    String _uid = uid;
    getUserData(_uid);
    notifyListeners();
    return uid;

  }
  var allData;
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String documentId) async {
    DocumentSnapshot<Map<String, dynamic>> userData =
    await FirebaseFirestore.instance.collection('users').doc(documentId).get();
    allData = userData;
    notifyListeners();
    return userData;
  }
}

