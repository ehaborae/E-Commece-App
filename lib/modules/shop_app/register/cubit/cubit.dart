import 'package:e_commerce/models/shop_app/login_model.dart';
import 'package:e_commerce/modules/shop_app/register/cubit/states.dart';
import 'package:e_commerce/shared/network/end_points.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  late LoginModel registerModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      lang: 'en',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      print(value.data);

      registerModel = LoginModel.fromJson(value.data);
      if (registerModel.status) {
        print(registerModel.status);
        print(registerModel.message);
        print(registerModel.data?.name);
        print(registerModel.data?.id);
        print(registerModel.data?.token);

        emit(RegisterSuccessState(registerModel));
      } else {
        print(registerModel.status);
        print(registerModel.message);
        emit(RegisterSuccessState(registerModel));
      }
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}
