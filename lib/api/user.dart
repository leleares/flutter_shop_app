import 'package:flutter_shop_app/constants/index.dart';
import 'package:flutter_shop_app/utils/DioRequest.dart';
import 'package:flutter_shop_app/viewmodels/user.dart';

Future<UserInfo> loginRequest(LoginRequest data) async {
  Map<String, dynamic> result = await dioRequest.post(
    HttpConstants.LOGIN,
    data: data.toJson(),
  );
  UserInfo userInfo = UserInfo.fromJSON(result);
  return userInfo;
}
