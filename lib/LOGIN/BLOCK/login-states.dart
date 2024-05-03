import 'package:store_app/MODELS/login-model.dart';

abstract class Login_States {}

class Login_Initial_State extends Login_States {}

class Login_password_State extends Login_States {}

class Login_Loding_State extends Login_States {}
class Login_Success_State extends Login_States {
   final Login_Model logimodel;
  Login_Success_State({required this.logimodel});
}
class Login_Error_State extends Login_States {}
