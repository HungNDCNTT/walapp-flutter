import 'package:get/get.dart';

import '../../../model/entities/user/user_entity.dart';
import '../../../model/enums/load_status.dart';
import '../../../repositories/auth_repository.dart';
import '../../../router/route_config.dart';
import '../../../utils/firebase_utils.dart';
import '../../../utils/logger.dart';
import '../../commons/app_snackbar.dart';
import '../main/main_view.dart';
import 'sign_in_state.dart';

class SignInLogic extends GetxController {
  final state = SignInState();

  void signIn() async {
    state.signInStatus.value = LoadStatus.loading;
    try {
      final token = await FirebaseUtils.signInWithGoogle();
      if (token != null) {
        state.signInStatus.value = LoadStatus.success;
        Get.offAll(MainPage());
      } else {
        state.signInStatus.value = LoadStatus.failure;
      }
    } catch (e) {
      state.signInStatus.value = LoadStatus.failure;
    }
  }
}
