class Category_Details {
  bool? status;
  Null message;
  Data? data;

  Category_Details.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] =  Data.fromJson(json['data']) ;
  }


}

class Data {
  dynamic? currentPage;
  List<ProductsDatas> productData=[];
  String? firstPageUrl;
  dynamic? from;
  dynamic? lastPage;
  String? lastPageUrl;
  Null nextPageUrl;
  String? path;
  dynamic? perPage;
  Null prevPageUrl;
  dynamic? to;
  dynamic? total;



  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

      json['data'].forEach((v) {
        productData.add( ProductsDatas.fromJson(v));
      });

    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }


}

class ProductsDatas {
  dynamic? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  String? description;
  List images=[];
  bool? inFavorites;
  bool? inCart;



  ProductsDatas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }


}