import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/component/round_button.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  ValueNotifier<bool> obsecureVal = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Center(
                  child: Icon(
                    Icons.face,
                    size: 120,
                  ),
                ),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: emailCon,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      hintText: "Email",
                      label: Text("Email"),
                      prefixIcon: Icon(Icons.email)),
                ),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                    valueListenable: obsecureVal,
                    builder: ((context, value, child) {
                      return TextField(
                        controller: passCon,
                        keyboardType: TextInputType.text,
                        obscureText: obsecureVal.value,
                        obscuringCharacter: '#',
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            hintText: "Password",
                            label: const Text("Password"),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: InkWell(
                              onTap: () {
                                obsecureVal.value = !obsecureVal.value;
                              },
                              child: Icon(obsecureVal.value
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash),
                            )),
                      );
                    })),
                const SizedBox(
                  height: 40,
                ),
                RoundButton(
                  title: 'Sign in',
                  onTap: () {
                    if (emailCon.text.trim().isEmpty) {
                      Utils.toastMessage("Must Enter Email");
                      return;
                    }
                    if (passCon.text.trim().isEmpty) {
                      Utils.toastMessage("Must Enter Password");
                      return;
                    }
                    Map data = {
                      'email': emailCon.text.trim(),
                      'password': passCon.text.trim()
                    };

                    authViewModel.loginApi(data);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
