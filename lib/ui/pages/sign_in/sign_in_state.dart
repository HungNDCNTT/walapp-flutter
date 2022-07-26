import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/enums/load_status.dart';
import '../../widgets/input/app_password_input.dart';

class SignInState {
  late TextEditingController usernameTextController;
  late TextEditingController passwordTextController;

  late ObscureTextController obscurePasswordController;

  final signInStatus = LoadStatus.initial.obs;

  SignInState() {
    usernameTextController = TextEditingController(text: 'thoson.it@gmail.com');
    passwordTextController = TextEditingController(text: "Son@1234");
    obscurePasswordController = ObscureTextController(obscureText: true);
  }
}
