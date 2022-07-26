import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walapp/common/app_size.dart';

import '../../../common/app_colors.dart';
import '../../../generated/l10n.dart';
import 'sign_in_logic.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInLogic logic = Get.put(SignInLogic());

  @override
  void dispose() {
    Get.delete<SignInLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: buildBodyWidget(),
    );
  }

  Widget buildBodyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buttonWidget(),
      ],
    );
  }

  Widget buttonWidget() {
    return GestureDetector(
      onTap:()=> logic.signIn(),
      child: Container(
        width: double.infinity,
        height: AppSize().getHeight(30),
        margin: EdgeInsets.symmetric(horizontal: AppSize().getWidth(30)),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text(S.of(context).button_sign_in_google)),
      ),
    );
  }
}
