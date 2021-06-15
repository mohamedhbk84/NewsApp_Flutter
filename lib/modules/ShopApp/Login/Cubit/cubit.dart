import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Network/end_Point.dart';
import 'package:news/Network/remote/DioHelper.dart';
import 'package:news/models/Shop_App/LoginShop.dart';
import 'package:news/modules/ShopApp/Login/Cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitaintStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel shopLoginModel;

  bool shownPassword = true;
  void changePassword() {
    shownPassword = !shownPassword;
    emit(LoginChangeLockPassword());
  }

  ////////////////////////////////////
  void userLogin({String email, String password}) {
    emit(LoginLoadingStates());
    DioHelper.postData(url: Login, data: {'email': email, 'password': password})
        .then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(LoginScussedStates(shopLoginModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(LoginErrorStates(onError));
    });
  }
}
