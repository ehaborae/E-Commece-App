// ignore_for_file: unnecessary_statements

import 'package:buildcondition/buildcondition.dart';
import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/layouts/shop_app/shop_layout.dart';
import 'package:e_commerce/modules/shop_app/admin_screen/admin_screen.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:e_commerce/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AdminLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              showToast(
                  message: state.loginModel.message,
                  toastStates: ToastStates.SUCCESS);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                ShopCubit.get(context).currentIndex = 0;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              showToast(
                  message: state.loginModel.message,
                  toastStates: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ADMIN LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            label: 'Email Address',
                            prefix: Icons.email_outlined,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email address';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            isPassword: ShopCubit.get(context).isPassword,
                            suffixPressed: () {
                              ShopCubit.get(context).changePasswordVisibility();
                            },
                            suffix: ShopCubit.get(context).suffix,
                            controller: passwordController,
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            type: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password is to short';
                              }
                            }),
                        SizedBox(
                          height: 30.0,
                        ),
                        BuildCondition(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                            context: context,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                if (emailController.text == 'admin') {
                                  if (passwordController.text == '123456') {


                                    navigateAndFinish(context, AdminScreen());


                                  } else {
                                    showToast(
                                        message: 'Password is incorrect',
                                        toastStates: ToastStates.ERROR);
                                    passwordController.clear();
                                  }
                                }else{
                                  showToast(
                                      message: 'Email is incorrect',
                                      toastStates: ToastStates.ERROR);
                                  emailController.clear();
                                }
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
