// import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/Cubit/Cubit.dart';
import 'package:news/shared/Cubit/States.dart';
import 'package:news/shared/component/componentButton.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, states) => {},
      builder: (context, states) {
        var list = AppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            title: Text("News"),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: defaultTextField(
                  context: context,
                  controller: searchController,
                  type: TextInputType.text,
                  onchanege: (String value) {
                    AppCubit.get(context).getSearch(value);
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Search not be empty';
                    }
                    return null;
                  },
                  icon: Icons.search,
                  label: "Search",
                  isShown: false,
                  istrue: false,
                ),
              ),
              Expanded(
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildArticalItem(list[index], context),
                    separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsetsDirectional.only(start: 24),
                          child: Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey),
                        ),
                    itemCount: list.length),
              ),
            ],
          ),
        );
      },
    );
  }
}
