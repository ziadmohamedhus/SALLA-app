class UserData_Model {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final int points;
  final int credit;
  final String token;
  UserData_Model(
      {required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.image,
        required this.points,
        required this.credit,
        required this.token
      });


  factory UserData_Model.fromJson(jsonData) {
    return UserData_Model(
        id: jsonData['id'],
        name: jsonData['name'],
        email: jsonData['email'],
        image: jsonData['image'],
        points: jsonData['points'],
        credit: jsonData['credit'],
        token: jsonData['token'],
        phone: jsonData['phone']);

  }
}

class Login_Model {
   bool status=false;
   String? message;
  UserData_Model? data;



   Login_Model.fromJson(jsonData) {

        status= jsonData['status'];
        message= jsonData['message'];
        data= jsonData['data'] != null ? UserData_Model.fromJson(jsonData['data']) :null;

  }
}