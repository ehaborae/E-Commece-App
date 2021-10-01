import 'package:e_commerce/modules/shop_app/login/login_screen.dart';
import 'package:e_commerce/shared/network/local/cache_helper.dart';

import 'components.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      showToast(
          message: 'Sign out Successfully', toastStates: ToastStates.SUCCESS);
      navigateAndFinish(context, LoginScreen());
    }
  });
}

var token;
