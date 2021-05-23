import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:news/Network/local/cache_helper.dart';
import 'package:news/Network/remote/DioHelper.dart';
import 'package:news/modules/Business/Business.dart';
import 'package:news/modules/Science/Science.dart';
import 'package:news/modules/Sports/Sports.dart';
import 'package:news/shared/Cubit/States.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitioalSates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currenindex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
  ];

  var screen = [
    BusinessBottom(),
    ScienceBottom(),
    SportsBottom(),
  ];
  void changeBottomNav(int index) {
    currenindex = index;
    if (index == 1) getScience();
    if (index == 2) getSports();
    emit(AppChangeBottomNavStates());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(AppLoadingBusinessStates());
    DioHelper.getData(url: "v2/top-headlines", query: {
      'country': 'eg',
      'category': 'business',
      'apikey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      business = value.data['articles'];
      print(business);
      emit(AppGetBusinessStates());
    }).catchError((onError) {
      print("error $onError");
      emit(ApperrotLoadingBusinessStates());
    });
  }

  List<dynamic> science = [];
  void getScience() {
    emit(AppLoadingScienceStates());
    DioHelper.getData(url: "v2/top-headlines", query: {
      'country': 'eg',
      'category': 'science',
      'apikey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      science = value.data['articles'];
      print(business);
      emit(AppGetScienceStates());
    }).catchError((onError) {
      print("error $onError");
      emit(ApperrotLoadingScienceStates());
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(AppLoadingSportsStates());
    DioHelper.getData(url: "v2/top-headlines", query: {
      'country': 'eg',
      'category': 'sports',
      'apikey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      sports = value.data['articles'];
      print(business);
      emit(AppGetSportsStates());
    }).catchError((onError) {
      print("error $onError");
      emit(ApperrotLoadingSportsStates());
    });
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(AppLoadingSearchStates());
    DioHelper.getData(url: "v2/everything", query: {
      'q': '$value',
      'apikey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      search = value.data['articles'];
      print(search);
      emit(AppGetSearchStates());
    }).catchError((onError) {
      print("error $onError");
      emit(ApperrotLoadingSearchStates());
    });
  }

//////// shared preferance /////

  bool isDark = false;

  void changeModeDark(
      //   bool fromShare
      ) {
    // if (isDark != null)
    //   isDark = fromShare;
    // else
    isDark = !isDark;
    emit(AppChangeModeDarkStates());

    // CacheHelper.putData(key: 'isDark', value: isDark).then((value) {});
  }
}
