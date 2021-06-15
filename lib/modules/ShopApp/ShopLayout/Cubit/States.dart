import 'package:news/models/Shop_App/change_Favourite.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

class ShopLoadingHomeStates extends ShopStates {}

class ShopSucessHomeStates extends ShopStates {}

class ShopErrorHomeStates extends ShopStates {}

class ShopSucessGetCategoryStates extends ShopStates {}

class ShopErrorGetCategoryStates extends ShopStates {}

class ShopSucessGetFavouriteStates extends ShopStates {
  final ChangeFavouriteModel model;

  ShopSucessGetFavouriteStates(this.model);
}

class ShopSucessFavouriteStates extends ShopStates {}

class ShopErrorGetFavouriteStates extends ShopStates {}

class ShopFavouritLoadingStates extends ShopStates {}

class ShopFavouritScussesStates extends ShopStates {}

class ShopFavouritErrorStates extends ShopStates {}

class ShopSettingSucessStates extends ShopStates {}

class ShopSettingErrorStates extends ShopStates {}

class ShopSearchSucessStates extends ShopStates {}

class ShopSearchErrorStates extends ShopStates {}

class ShopContactsLoadingStates extends ShopStates {}

class ShopContactsSucessStates extends ShopStates {}

class ShopContactsErrorStates extends ShopStates {}

class ShopComplaintLoadingStates extends ShopStates {}

class ShopComplaintSucessStates extends ShopStates {}

class ShopComplaintErrorStates extends ShopStates {}
