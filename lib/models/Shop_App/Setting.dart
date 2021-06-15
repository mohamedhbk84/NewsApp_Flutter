// class SettingModel {
//   bool status;
//   Data data;
//   SettingModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = Data.fromJson(json['data']);
//     // != null ? Data.fromJson(json['data']) : null;
//   }
// }

// class Data {
//   String about;
//   String terms;
//   Data.fromJson(Map<String, dynamic> json) {
//     about = json['about'];
//     terms = json['terms'];
//   }
// }

class SettingModel {
  bool status;
  Data data;
  SettingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int id;
  String name;
  String email;
  String phone;
  String image;
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }
}
