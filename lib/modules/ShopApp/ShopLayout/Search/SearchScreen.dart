import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/ShopApp/ShopLayout/Cubit/Cubit.dart';
import 'package:news/modules/ShopApp/ShopLayout/Search/SearchCubit.dart/SearchCubit.dart';
import 'package:news/modules/ShopApp/ShopLayout/Search/SearchCubit.dart/SearchStates.dart';
import 'package:news/shared/component/componentButton.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, states) => {},
        builder: (context, states) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: defaultTextField(
                      context: context,
                      controller: searchController,
                      type: TextInputType.text,
                      onchanege: (String value) {
                        // ShopCubit.get(context).searchProduct(value);
                        SearchCubit.get(context).search(value);
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Search not be empty';
                        }
                        return null;
                      },
                      label: "Search",
                      icon: Icons.search,
                      isShown: false,
                      istrue: false,
                    ),
                  ),
                  if (states is SearchLoadingStates) LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (states is SearchScuessStates)
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context)
                                  .searchModel
                                  .data
                                  .data[index],
                              context,
                              isOldPrice: false),
                          //  buildProductItem(ShopCubit.get(context).searchProductModel.[index].product, context),
                          separatorBuilder: (context, index) => Padding(
                                padding: EdgeInsetsDirectional.only(start: 24),
                                child: Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: Colors.grey),
                              ),
                          itemCount: SearchCubit.get(context)
                              .searchModel
                              .data
                              .data
                              .length),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildListProduct(
    model,
    context, {
    bool isOldPrice = true,
  }) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.price.toString(),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (model.discount != 0 && isOldPrice)
                          Text(
                            model.oldPrice.toString(),
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavourit(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:
                                ShopCubit.get(context).favourites[model.id]
                                    ? Colors.blue
                                    : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
