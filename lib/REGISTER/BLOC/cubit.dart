import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/MODELS/login-model.dart';
import 'package:store_app/REGISTER/BLOC/states.dart';
import 'package:store_app/DIO/dio-helper.dart';

class Register_Cubit extends Cubit<ShopRegisterStates> {
  Register_Cubit() : super(ShopRegisterInitialState());

  static Register_Cubit get(context) => BlocProvider.of(context);

  Login_Model? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    emit(ShopRegisterLoadingState());

    diohelper.postdata(

      data:
      {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
      URL: 'register',
    ).then((value)
    {
      print(value.data);
      loginModel = Login_Model.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}