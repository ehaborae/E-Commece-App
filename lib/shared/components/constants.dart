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

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String? token;
String? address;
String? paymentMethod;
bool? isInProgress;

List<String> addresses = [
  '14, Ahmed Orabi, Zagazig, Sharkia',
  '15, Ahmed Orabi, Zagazig, Sharkia',
  '16, Ahmed Orabi, Zagazig, Sharkia',
  '17, Ahmed Orabi, Zagazig, Sharkia',
];

List<String> paymentMethodList = [
  'VISA',
  'Cash on delivery',
];
