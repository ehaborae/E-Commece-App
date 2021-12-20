import 'package:buildcondition/buildcondition.dart';
import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/layouts/shop_app/shop_layout.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:e_commerce/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.status) {
              print(state.registerModel.message);
              print(state.registerModel.data!.token);
              showToast(
                  message: state.registerModel.message,
                  toastStates: ToastStates.SUCCESS);
              CacheHelper.saveData(
                      key: 'token', value: state.registerModel.data!.token)
                  .then((value) {
                token = state.registerModel.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              showToast(
                  message: state.registerModel.message,
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
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            label: 'Name',
                            prefix: Icons.person,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            label: 'Phone',
                            prefix: Icons.phone,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
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
                            isPassword:
                                ShopCubit.get(context).isPasswordRegister,
                            suffixPressed: () {
                              ShopCubit.get(context)
                                  .registerChangePasswordVisibility();
                            },
                            suffix: ShopCubit.get(context).suffixRegister,
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
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).userRegister(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
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
