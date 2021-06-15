import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/MenuItem/Complaint.dart';
// import 'package:news/Network/local/cache_helper.dart';
// import 'package:news/modules/ShopApp/Login/login.dart';
import 'package:news/modules/ShopApp/ShopLayout/Cubit/Cubit.dart';
import 'package:news/modules/ShopApp/ShopLayout/Cubit/States.dart';
import 'package:news/modules/ShopApp/ShopLayout/Search/SearchScreen.dart';
import 'package:news/shared/component/componentButton.dart';
// import 'package:news/shared/component/componentButton.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text("sallla"),
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    })
              ],
            ),
            drawer: Padding(
              padding: EdgeInsets.only(right: 140, bottom: 270),
              child: Drawer(
                elevation: 20,
                child: Container(
                  color: Colors.blue,
                  child: ListView(
                    children: [
                      buildMenuItem(
                          color: Colors.white,
                          iconData: Icons.compass_calibration,
                          text: "Complaint",
                          onSelected: () {
                            navigateTo(context, ComplaintScreen());
                          }),
                      buildMenuItem(
                          color: Colors.white,
                          iconData: Icons.verified_user_outlined,
                          text: "verification"),
                      buildMenuItem(
                          color: Colors.white,
                          iconData: Icons.add_a_photo,
                          text: "add photo"),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentindex,
                backgroundColor: Colors.red,
                unselectedItemColor: Colors.grey,
                unselectedLabelStyle:
                    TextStyle(backgroundColor: Colors.grey, color: Colors.grey),
                selectedItemColor: Colors.red,
                onTap: (value) {
                  cubit.changeItem(value);
                },
                items: cubit.bottomItem),
            body: cubit.screen[cubit.currentindex]
            // TextButton(
            //   onPressed: () {

            //     });
            //   },
            //   child: Text("LogOut",
            //       style: TextStyle(
            //         color: Colors.green,
            //         fontSize: 26,
            //       )),
            // ),
            );
      },
    );
  }

  Widget buildMenuItem(
          {IconData iconData, String text, Color color, Function onSelected}) =>
      ListTile(
        leading: Icon(
          iconData,
          color: color,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: color,
          ),
        ),
        onTap: onSelected,
      );
}
