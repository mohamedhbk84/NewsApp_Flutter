import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/Cubit/Cubit.dart';
import 'package:news/shared/Cubit/States.dart';
import 'package:news/shared/component/componentButton.dart';

class BusinessBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, states) => {},
        builder: (context, states) {
          var list = AppCubit.get(context).business;
          return ConditionalBuilder(
            condition: states is! AppLoadingBusinessStates,
            builder: (context) => ListView.separated(
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
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
