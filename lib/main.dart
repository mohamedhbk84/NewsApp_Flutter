import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Network/remote/DioHelper.dart';
import 'package:news/modules/ShopApp/Login/login.dart';
import 'package:news/modules/ShopApp/ShopLayout/Cubit/Cubit.dart';
import 'package:news/modules/ShopApp/ShopLayout/ShopLayout.dart';

import 'package:news/modules/ShopApp/onBoarding/boarding.dart';
import 'package:news/shared/Cubit/Cubit.dart';
import 'package:news/shared/Cubit/States.dart';
import 'package:news/shared/bloc_observer.dart';
import 'package:news/styles/constance.dart';
import 'package:news/styles/themes.dart';

import 'Network/local/cache_helper.dart';

void main() async {
  //////// علشان اتاكد انة لازما يرن الحاجات اللى معمول ليها انتظار وبعد كدة يفتح التطبيق
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  // bool isDark = CacheHelper.getData(key: 'isDark');
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);
  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardinScreen();
  }
  print(onBoarding);
  DioHelper.init();

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // final bool isDark;
  // MyApp(this.isDark);
  final Widget startWidget;
  MyApp({this.startWidget});
  // This widget is the root of your application.  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => AppCubit()..getBusiness(),
          ),
          BlocProvider(
              create: (BuildContext context) => ShopCubit()
                ..getHomeData()
                ..getCategory()
                ..getFavourit()
                ..getsetting()
                ..contacts())
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, states) => {},
          builder: (context, states) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lighttheme,
                darkTheme: darttheme,
                ////////////////////////////////
                themeMode: AppCubit.get(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                // theme: ThemeData(
                //   primarySwatch: Colors.blue,
                // ),
                home: startWidget
                // onBoardaing ? LoginScreen() : OnBoardinScreen(),
                );
          },
        ));
  }
}
