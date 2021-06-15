import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Network/end_Point.dart';
import 'package:news/Network/remote/DioHelper.dart';
import 'package:news/models/Shop_App/SearchProduct.dart';
import 'package:news/modules/ShopApp/ShopLayout/Search/SearchCubit.dart/SearchStates.dart';
import 'package:news/styles/constance.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitionalStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;
  void search(String text) {
    emit(SearchLoadingStates());
    DioHelper.postData(url: SearchProductt, token: token, data: {'text': text})
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchScuessStates());
    }).catchError((onError) {
      print(onError.toString());
      emit(SearchErrorStates());
    });
  }
}
