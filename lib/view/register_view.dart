import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/component/round_button.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                    Icons.app_registration,
                    size: 120,
                  ),
                ),
                const Text(
                  'Register Account!',
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
                  title: 'Register',
                  loading: authViewModel.loading,
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

                    authViewModel.registerApi(context, data);
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.black45),
                        ),
                        Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        )
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
