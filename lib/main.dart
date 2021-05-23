import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/Network/remote/DioHelper.dart';
import 'package:news/layout/New.dart';
import 'package:news/shared/Cubit/Cubit.dart';
import 'package:news/shared/Cubit/States.dart';
import 'package:news/shared/bloc_observer.dart';

import 'Network/local/cache_helper.dart';

void main() async {
  //////// علشان اتاكد انة لازما يرن الحاجات اللى معمول ليها انتظار وبعد كدة يفتح التطبيق
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  // bool isDark = CacheHelper.getData(key: 'isDark');
  DioHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final bool isDark;
  // MyApp(this.isDark);
  // This widget is the root of your application.  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..getBusiness(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, states) => {},
          builder: (context, states) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.dark,
                        statusBarColor: Colors.amberAccent),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.black),
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: Colors.white,
                  )),
              darkTheme: ThemeData(
                scaffoldBackgroundColor: HexColor("#333739"),
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light,
                      statusBarColor: Colors.amberAccent),
                  backgroundColor: HexColor("#333739"),
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.white),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor("#333739"),
                ),
              ),
              ////////////////////////////////
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              // theme: ThemeData(
              //   primarySwatch: Colors.blue,
              // ),
              home: NewsScreen(),
            );
          },
        ));
  }
}
