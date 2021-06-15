import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Network/end_Point.dart';
import 'package:news/Network/remote/DioHelper.dart';
import 'package:news/models/Shop_App/Contacts.dart';
import 'package:news/models/Shop_App/Favourit.dart';
import 'package:news/models/Shop_App/GetCategory.dart';
import 'package:news/models/Shop_App/HomeModel.dart';
import 'package:news/models/Shop_App/OtherModel/Complaints.dart';
import 'package:news/models/Shop_App/Setting.dart';
import 'package:news/models/Shop_App/change_Favourite.dart';
import 'package:news/modules/ShopApp/ShopLayout/Cubit/States.dart';
import 'package:news/modules/ShopApp/ShopLayout/Setting/SettingScreen.dart';
import 'package:news/modules/ShopApp/ShopLayout/category/CategoryScreen.dart';
import 'package:news/modules/ShopApp/ShopLayout/favourit/FavouritScreen.dart';
import 'package:news/modules/ShopApp/ShopLayout/product/ProductScreen.dart';
// import 'package:news/shared/component/componentButton.dart';
import 'package:news/styles/constance.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  var screen = [
    ProductsScreen(),
    CategoryScreen(),
    FavouritScreen(),
    SettingScreen(),
  ];

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
        icon: Icon(Icons.preview_rounded), label: "Production"),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: "Category"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourit"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
  ];

  void changeItem(int index) {
    currentindex = index;
    emit(ShopChangeBottomNavStates());
  }

  ShopHomeModel shopHomeModel;
  Map<int, bool> favourites = {};

  void getHomeData() {
    emit(ShopLoadingHomeStates());
    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      shopHomeModel = ShopHomeModel.fromJson(value.data);
      shopHomeModel.data.products.forEach((element) {
        favourites.addAll({
          element.id: element.infavorites,
        });
      });
      print(favourites.toString());
      // printFullText(shopHomeModel.data.banners[0].image);
      // print(shopHomeModel.toString());
      emit(ShopSucessHomeStates());
    }).catchError((onError) {
      emit(ShopErrorHomeStates());
    });
  }

  CategoriesModel categoriesModel;
  void getCategory() {
    DioHelper.getData(
      url: Get_Category,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      print(categoriesModel.data.currentPage);
      emit(ShopSucessGetCategoryStates());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorGetCategoryStates());
    });
  }

  ChangeFavouriteModel changeFavouriteModel;
  void changeFavourit(int productid) {
    favourites[productid] = !favourites[productid];
    DioHelper.postData(
      url: Favorites,
      data: {'product_id': productid},
      token: token,
    ).then((value) {
      changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
      print(value.data);
      if (!changeFavouriteModel.status) {
        favourites[productid] = !favourites[productid];
      } else {
        getFavourit();
      }
      emit(ShopSucessFavouriteStates());
    }).catchError((onError) {
      favourites[productid] = !favourites[productid];
      emit(ShopErrorGetFavouriteStates());
    });
  }

  FavouritModel favouritModel;

  void getFavourit() {
    emit(ShopFavouritLoadingStates());
    DioHelper.getData(url: Favorites, token: token)
        // "XXUywrnbti1SuTtBQ4d3pl3a716TfCCKCwGGLFGO2gjBX0G8Koi64scWuXsAdVmEWTJJkS")
        .then((value) {
      favouritModel = FavouritModel.fromJson(value.data);
      emit(ShopFavouritScussesStates());
    }).catchError((onError) {
      emit(ShopFavouritErrorStates());
    });
  }

  SettingModel settingModel;
  void getsetting() {
    DioHelper.getData(
      url: 'profile',
      token: token,
    ).then((value) {
      settingModel = SettingModel.fromJson(value.data);
      // print(settingModel.data.about);
      emit(ShopSettingSucessStates());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopSettingErrorStates());
    });
  }

  ContactsModel contactsmodel;

  void contacts() {
    emit(ShopContactsLoadingStates());
    DioHelper.getData(url: Contacts).then((value) {
      contactsmodel = ContactsModel.fromJson(value.data);
      print(categoriesModel.data.currentPage);
      emit(ShopContactsSucessStates());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopContactsErrorStates());
    });
  }

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
  ComplaintModel complaintModel;
  void getComplaint({String name}) {
    emit(ShopComplaintLoadingStates());
    DioHelper.postData(
      url: Complaints,
      data: {'name': name},
      token: token,
    ).then((value) {
      complaintModel = ComplaintModel.fromJson(value.data);
      emit(ShopComplaintSucessStates());
    }).catchError((onError) {
      emit(ShopComplaintErrorStates());
    });
  }
}
