import 'package:e_commerce/modules/shop_app/search/cubit/cubit.dart';
import 'package:e_commerce/modules/shop_app/search/cubit/states.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      label: 'Search',
                      prefix: Icons.search,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Search some thing';
                        } else {
                          return null;
                        }
                      },
                      onSubmit: (value) {
                        if (formKey.currentState!.validate()) {
                          SearchCubit.get(context)
                              .search(text: searchController.text);
                        }
                      },
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildListProducts(
                                SearchCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .data[index],
                                context, isSearch: true),
                            separatorBuilder: (context, index) => Container(
                                  width: double.infinity,
                                  height: 3,
                                ),
                            itemCount: SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data
                                .length),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
