import 'package:e_commerce/models/shop_app/login_model.dart';
import 'package:e_commerce/modules/shop_app/login/cubit/states.dart';
import 'package:e_commerce/shared/network/end_points.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      lang: 'en',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);

      loginModel = LoginModel.fromJson(value.data);
      if(loginModel.status)
      {
        print(loginModel.status);
        print(loginModel.message);
        print(loginModel.data?.name);
        print(loginModel.data?.id);
        print(loginModel.data?.token);

        emit(LoginSuccessState(loginModel));
      } else
      {
        print(loginModel.status);
        print(loginModel.message);
        emit(LoginSuccessState(loginModel));
      }
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }
}
