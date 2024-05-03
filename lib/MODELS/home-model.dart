class Home_Model
{
  bool? status;
  Home_Data_Model? data;

  Home_Model.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = Home_Data_Model.fromJson(json['data']);
  }
}

class Home_Data_Model
{
  List<Banner_Model> banners = [];
  List<Product_Model> products = [];

  Home_Data_Model.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(Banner_Model.fromJson(element));
    });

    json['products'].forEach((element)
    {
      products.add(Product_Model.fromJson(element));
    });
  }
}

class Banner_Model
{
  int? id;
  String? image;

  Banner_Model.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}

class Product_Model
{
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  Product_Model.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}