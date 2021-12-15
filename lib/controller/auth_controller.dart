import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  var isLoading = false.obs;
  @override
  Future<void> submit(
      String userName, String email, String password, bool isLogin) async {
    UserCredential userCredential;
    print("Hello");
    try {
      isLoading.value = true;
      if (isLogin) {
        print("login");
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential.user!.uid)
            .set({
          'username': userName,
          'email': email,
        });
      }
    } on PlatformException catch (error) {
      var message = "Somthing want wrong";
      if (error.message != null) {
        message = error.message!;
      }
      isLoading.value = false;
      throw message;
      // print(message);
    } catch (error) {
      // print(error);

      isLoading.value = false;
      rethrow;
    }
  }
}
