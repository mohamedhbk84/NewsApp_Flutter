import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/NewsApp/Search/Search.dart';
import 'package:news/shared/Cubit/Cubit.dart';
import 'package:news/shared/Cubit/States.dart';
import 'package:news/shared/component/componentButton.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, states) => {},
        builder: (context, states) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("News"),
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    }),
                IconButton(
                    icon: Icon(Icons.brightness_4_rounded),
                    onPressed: () {
                      AppCubit.get(context).changeModeDark();
                    }),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (value) {
                  cubit.changeBottomNav(value);
                },
                currentIndex: cubit.currenindex,
                items: cubit.bottomItem),
            body: cubit.screen[cubit.currenindex],
          );
        });
  }
}

// test Data //////////
// floatingActionButton: FloatingActionButton(
//   onPressed: () {
//     DioHelper.getData(url: 'v2/top-headlines', query: {
//       'country': 'eg',
//       'category': 'business',
//       'apikey': '65f7f556ec76449fa7dc7c0069f040ca',
//     }).then((value) {
//       print(value.data['articles']);
//     }).catchError((error) {
//       print(error.toString());
//     });
//   },
//   child: Center(
//     child: Icon(Icons.add),
//   ),
// ),
