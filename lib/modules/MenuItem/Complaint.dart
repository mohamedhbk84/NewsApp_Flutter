import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/ShopApp/Notification/Cubit/Cubit.dart';
import 'package:news/modules/ShopApp/Notification/Cubit/States.dart';

class ComplaintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NotificationCubit()..getNotification(),
      child: BlocConsumer<NotificationCubit, NotificationStates>(
        listener: (context, states) => {},
        builder: (context, states) {
          return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  Text(NotificationCubit.get(context)
                      .notificationModel
                      .data
                      .data[0]
                      .message),
                  Text(NotificationCubit.get(context)
                      .notificationModel
                      .data
                      .data[0]
                      .title),
                ],
              ));
        },
      ),
    );
  }
}
