import 'package:get_storage/get_storage.dart';

class MyPref {
  static final _box = () => GetStorage('MyPref');

  static final userId = ReadWriteValue('userId', '', _box);
  static final firstTimeUser = ReadWriteValue('firstTimeUser', true, _box);
  static final authToken = ReadWriteValue('auth-token', '', _box);
  static final logInDetail = ReadWriteValue('logInDeatail', '', _box);
  static final userDetail = ReadWriteValue('userProfile', '', _box);
  static final bankListDetail = ReadWriteValue('bankListDeatail', '', _box);
  static final genKyc = ReadWriteValue('genKyc', '', _box);
  static final setOverlay = ReadWriteValue('setOverlay', false, _box);
  static final setSubscribeOverlay =
      ReadWriteValue('setSubscribeOverlay', false, _box);
  static final userDetails = ReadWriteValue('userDetails', '', _box);

  static final userCart = ReadWriteValue('userCart', '', _box);

  static Future<void> clearBoxes() async {
    await _box().erase();
  }
}
