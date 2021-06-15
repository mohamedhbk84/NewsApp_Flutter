class ContactsModel {
  bool status;
  String message;
  Data data;
  ContactsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int currentpage;
  List<DataModel> data = [];
  // String firstPageUrl;
  // int from;
  // int lastPage;
  // String lastPageUrl;
  // Null nextPageUrl;
  // String path;
  // int perPage;
  // Null prevPageUrl;
  // int to;
  // int total;
  Data.fromJson(Map<String, dynamic> json) {
    currentpage = json['current_page'];

    json['data'].forEach((v) {
      data.add(DataModel.fromJson(v));
    });
  }
}

class DataModel {
  int id;
  int type;
  String value;
  String image;
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
    image = json['image'];
  }
}
