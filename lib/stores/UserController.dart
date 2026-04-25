import 'package:flutter_shop_app/viewmodels/user.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

// 全局共用 store
class UserController extends GetxController {
  var user = UserInfo.fromJSON({}).obs; // user 对象被监控，即其为响应式对象，类似于vue中的ref

  void updateUserInfo(UserInfo userInfo) {
    user.value = userInfo;
  }
}
