import 'package:flutter/material.dart';
import 'package:mvvm/repository/auth_repository.dart';

class AuthViewModel with ChangeNotifier {
  final myRepo = AuthRepository();
  Future<void> loginApi(data) async {
    var res = myRepo.loginApi(data).then((value) {
      print(value.toString());
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
