import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/models/Shop_App/GetCategory.dart';
import 'package:news/modules/ShopApp/ShopLayout/Cubit/Cubit.dart';
import 'package:news/modules/ShopApp/ShopLayout/Cubit/States.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context).categoriesModel.data;
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(cubit.data[index]),
          separatorBuilder: (context, index) => SizedBox(
            height: 1,
          ),
          itemCount: cubit.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              model.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );
}
