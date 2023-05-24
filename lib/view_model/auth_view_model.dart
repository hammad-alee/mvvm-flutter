import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool v) {
    _loading = v;
    notifyListeners();
  }

  final myRepo = AuthRepository();
  Future<void> loginApi(context, data) async {
    setLoading(true);
    myRepo.loginApi(data).then((value) {
      setLoading(false);
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }

  Future<void> registerApi(context, data) async {
    setLoading(true);
    myRepo.registerApi(data).then((value) {
      if (kDebugMode) {
        print(data);
      }
      setLoading(false);
      //Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }
}
