class ShopHomeModel {
  bool status;
  HomeDataModel data;

  ShopHomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProuctsModel> products = [];
  String advanse;
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProuctsModel.fromJson(element));
    });

    advanse = json['ad'];
  }
}

class BannerModel {
  int id;
  String image;
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProuctsModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool infavorites;
  bool incart;

  ProuctsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
    infavorites = json['in_favorites'];
    incart = json['in_cart'];
  }
}
