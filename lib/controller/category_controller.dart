import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_practical/model/category.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController {
  RxList<Categoty> category = RxList<Categoty>([
    Categoty(id: null, categoryName: 'OutFits'),
    Categoty(id: null, categoryName: 'Tops'),
    Categoty(id: null, categoryName: 'Bottoms'),
    Categoty(id: null, categoryName: 'Shoes'),
  ]);
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addCategory(String categoryName) async {
    final User user = auth.currentUser!;
    final uid = user.uid;
    var url = Uri.parse(
        "https://flutter-practical-f90b9-default-rtdb.firebaseio.com/$uid/category.json");
    try {
      final response = await http.post(url,
          body: json.encode({
            'categoty': categoryName,
          }));

      category.add(Categoty(
          id: json.decode(response.body)['name'], categoryName: categoryName));
    } catch (error) {
      rethrow;
    }
  }
}
