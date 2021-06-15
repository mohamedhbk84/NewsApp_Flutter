import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Network/end_Point.dart';
import 'package:news/Network/remote/DioHelper.dart';
import 'package:news/models/Shop_App/LoginShop.dart';
import 'package:news/modules/ShopApp/Register_Screen/Cubit/RegisterStates.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitionalStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel registerModel;

  void register({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(RegisterLoadingStates());
    DioHelper.postData(url: Register, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      registerModel = ShopLoginModel.fromJson(value.data);
      emit(RegisterScuessStates(registerModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(RegisterErrorStates());
    });
  }

  bool showPassword = true;
  void changeShowPassword() {
    showPassword = !showPassword;
    emit(RegisterChangeShown());
  }
}
