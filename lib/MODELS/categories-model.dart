class Categories_Model
{
  bool? status;
  Categories_Data_Model? data;

  Categories_Model.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = Categories_Data_Model.fromJson(json['data']);
  }
}

class Categories_Data_Model
{
  int? currentPage;
  List<Data_Model> data = [];

  Categories_Data_Model.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'];
    json['data'].forEach((element)
    {
      data.add(Data_Model.fromJson(element));
    });
  }
}

class Data_Model
{
  int? id;
  String? name;
  String? image;

  Data_Model.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}