import 'package:e_commerce/models/shop_app/search.dart';
import 'package:e_commerce/modules/shop_app/search/cubit/states.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:e_commerce/shared/network/end_points.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  ShopSearchModel? searchModel;

  void search({
    required String text,
  }) {
    emit(SearchLoadingState());
    DioHelper.postData(
      data: {
        'text': text,
      },
      url: SEARCH,
      token: token,
    ).then((value) {
      searchModel = ShopSearchModel.fromJson(value.data);
      print(searchModel!.data!.data[0]);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState(error));
    });
  }
}
