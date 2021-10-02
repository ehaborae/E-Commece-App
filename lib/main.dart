import 'package:bloc/bloc.dart';
import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/layouts/shop_app/shop_layout.dart';
import 'package:e_commerce/modules/shop_app/login/login_screen.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:e_commerce/shared/network/local/cache_helper.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:e_commerce/shared/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding') == null
      ? false
      : CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token') == null
      ? null
      : CacheHelper.getData(key: 'token');

  if (onBoarding != false) {
    // ignore: unnecessary_null_comparison
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else
    widget = OnBoardingScreen();
  print(onBoarding);
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'E Commerce',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.shifting,
                elevation: 10,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
              ),
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.blue,),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'Jannah',
              primarySwatch: Colors.blue,
            ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
