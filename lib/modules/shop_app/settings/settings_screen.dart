import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              defaultFormField(
                controller: nameController,
                label: 'Name',
                prefix: Icons.person,
                type: TextInputType.text,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'Name must not be empty';
                  } else
                    return null;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              defaultFormField(
                controller: emailController,
                label: 'Email Address',
                prefix: Icons.email,
                type: TextInputType.emailAddress,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'Email must not be empty';
                  } else
                    return null;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              defaultFormField(
                controller: phoneController,
                label: 'Phone',
                prefix: Icons.phone,
                type: TextInputType.phone,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'Phone must not be empty';
                  } else
                    return null;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              defaultButton(
                function: () {
                  signOut(context);
                },
                text: 'logout',
              ),
            ],
          ),
        );
      },
    );
  }
}
