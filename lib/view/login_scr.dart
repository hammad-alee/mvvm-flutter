import 'package:flutter/material.dart';
import '../utils/utils.dart';

class LoginScr extends StatefulWidget {
  const LoginScr({super.key});

  @override
  State<LoginScr> createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  Utils.toastMessage('Test');
                  // Navigator.pushNamed(context, RoutesName.home);
                },
                child: const Text('Naviagte To Home'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
