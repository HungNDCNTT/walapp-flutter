import 'package:get/get.dart';

import '../model/entities/user/user_entity.dart';

class AppService extends GetxService {
  // Theme
  final Rx<UserEntity?> user = null.obs;

  Future<AppService> init() async {
    return this;
  }
}
