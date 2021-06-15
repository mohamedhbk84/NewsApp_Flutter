class NotificationModel {
  bool status;
  String message;
  Data data;
  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.forJson(json['data']) : null;
  }
}

class Data {
  int currentpage;
  List<ModelData> data = [];
  Data.forJson(Map<String, dynamic> json) {
    currentpage = json['current_page'];

    json['data'].forEcah((value) {
      data.add(ModelData.forJson(value));
    });
  }
}

class ModelData {
  int id;
  String title;
  String message;
  ModelData.forJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
  }
}
