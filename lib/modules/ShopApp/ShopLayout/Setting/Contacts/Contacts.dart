import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/models/Shop_App/Contacts.dart';
import 'package:news/modules/ShopApp/ShopLayout/Cubit/Cubit.dart';
import 'package:news/modules/ShopApp/ShopLayout/Cubit/States.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: state is! ShopFavouritLoadingStates,
              builder: (context) => ListView.separated(
                itemBuilder: (context, index) => getInformationContacts(
                  ShopCubit.get(context).contactsmodel.data.data[index],
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 1,
                ),
                itemCount:
                    ShopCubit.get(context).contactsmodel.data.data.length,
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ));
      },
    );
  }

  Widget getInformationContacts(DataModel model) => Column(
        children: [
          Center(
            child: Image(
              image: NetworkImage(model.image),
              width: 200,
              height: 100,
              color: Colors.red,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  "number : ${model.id}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Spacer(),
                Text(
                  "${model.value}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      );
}
