import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Network/remote/DioHelper.dart';
import 'package:news/modules/ShopApp/Notification/Cubit/States.dart';
import 'package:news/modules/ShopApp/Notification/Model/Model.dart';
import 'package:news/styles/constance.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit() : super(AppNotificationInitionalStates());

  static NotificationCubit get(context) => BlocProvider.of(context);
  NotificationModel notificationModel;
  void getNotification() {
    emit(AppLoadingNotificationStates());
    DioHelper.getData(url: 'notifications', token: token).then((value) {
      notificationModel = NotificationModel.fromJson(value.data);
      emit(AppScussesNotificationStates());
      print(notificationModel.data.data[1].message);
    }).catchError((onError) {
      print(onError.toString());
      emit(AppErrorNotificationStates());
    });
  }
}
