import 'package:e_commerce/modules/social_app/social_login_screen/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  // void userSocialLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(SocialLoginLoadingState());
  //   DioHelper.postData(
  //     url: LOGIN,
  //     lang: 'en',
  //     data: {
  //       'email': email,
  //       'password': password,
  //     },
  //   ).then((value) {
  //     print(value.data);
  //
  //     loginModel = SocialLoginModel.fromJson(value.data);
  //     if(loginModel.status)
  //     {
  //       print(loginModel.status);
  //       print(loginModel.message);
  //       print(loginModel.data?.name);
  //       print(loginModel.data?.id);
  //       print(loginModel.data?.token);
  //
  //       emit(SocialLoginSuccessState(loginModel));
  //     } else
  //     {
  //       print(loginModel.status);
  //       print(loginModel.message);
  //       emit(SocialLoginSuccessState(loginModel));
  //     }
  //   }).catchError((error) {
  //     emit(SocialLoginErrorState(error.toString()));
  //     print(error.toString());
  //   });
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialLoginChangePasswordVisibilityState());
  }
}
