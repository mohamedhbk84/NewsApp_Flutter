import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/models/Shop_App/GetCategory.dart';
import 'package:news/models/Shop_App/HomeModel.dart';
import 'package:news/modules/ShopApp/ShopLayout/Cubit/Cubit.dart';
import 'package:news/modules/ShopApp/ShopLayout/Cubit/States.dart';
import 'package:news/shared/component/componentButton.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) => {
        if (state is ShopSucessGetFavouriteStates)
          {
            if (!state.model.status)
              {
                showToast(text: state.model.message, states: ToastStates.Error),
              }
            else
              {
                showToast(
                    text: state.model.message, states: ToastStates.Sucess),
              }
          }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).shopHomeModel != null,
          builder: (context) => productBuilder(
              ShopCubit.get(context).shopHomeModel,
              ShopCubit.get(context).categoriesModel,
              context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productBuilder(
          ShopHomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel.data.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                color: Colors.grey[300],
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.72,
                  children: List.generate(
                      model.data.products.length,
                      (index) => buildGridProduct(
                          model.data.products[index], context)),
                )),
          ],
        ),
      );
  Widget buildGridProduct(ProuctsModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Column(
                  children: [
                    Image(
                      height: 200,
                      image: NetworkImage(model.image),
                      fit: BoxFit.fill,
                    ),
                    if (model.discount != 0)
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
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${model.name}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.0,
                              height: 1.1,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Salary ${model.price.round()}',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.orange,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              if (model.discount != 0)
                                Text(
                                  '${model.oldPrice.round()}',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  ShopCubit.get(context)
                                      .changeFavourit(model.id);
                                  print(model.id);
                                },
                                iconSize: 15,
                                icon: CircleAvatar(
                                  backgroundColor: ShopCubit.get(context)
                                          .favourites[model.id]
                                      ? Colors.blue
                                      : Colors.grey,
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(
              .8,
            ),
            width: 100.0,
            child: Text(
              model.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
