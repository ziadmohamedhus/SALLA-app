
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/DIO/dio-helper.dart';
import 'package:store_app/LOGIN/BLOCK/login-states.dart';
import 'package:store_app/MODELS/login-model.dart';

class Login_Cubit extends Cubit<Login_States> {
  Login_Cubit() :super(Login_Initial_State());

  //to access al elements in class
  static Login_Cubit get(context) => BlocProvider.of(context);

  late Login_Model userData;

  void Login_function({required String email,required String password})
  {
    emit(Login_Loding_State());
    diohelper.postdata(
        URL: 'login',
        data: {'email':email,'password':password}
    ).then((value) {
     print(value.data);
     userData=Login_Model.fromJson(value.data);
     print(userData.data!.token);
     emit(Login_Success_State(logimodel: userData));
    }).catchError((error)
    {
      print(error.toString());
      emit(Login_Error_State());
    });
  }


  IconData suffix=Icons.remove_red_eye_outlined ;
  bool pass=true;
  void Change_icon_password()
  {

    pass=!pass;
    suffix=pass ? Icons.remove_red_eye_outlined :Icons.visibility_off_outlined ;
    emit(Login_password_State());
  }
}