import 'package:news/models/Shop_App/LoginShop.dart';

abstract class RegisterStates {}

class RegisterInitionalStates extends RegisterStates {}

class RegisterLoadingStates extends RegisterStates {}

class RegisterScuessStates extends RegisterStates {
  final ShopLoginModel registerModel;

  RegisterScuessStates(this.registerModel);
}

class RegisterErrorStates extends RegisterStates {}

class RegisterChangeShown extends RegisterStates {}
