import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/BLOCK/states.dart';
import 'package:store_app/COMPONENTS/components.dart';
import 'package:store_app/DIO/dio-helper.dart';
import 'package:store_app/MODELS/change-favorites-model.dart';
import 'package:store_app/MODELS/home-model.dart';
import 'package:store_app/MODELS/login-model.dart';

import '../MODELS/categories-details-model.dart';
import '../MODELS/categories-model.dart';
import '../MODELS/get-favorites-model.dart';
import '../MODELS/product-details-model.dart';
import '../MODELS/search-model.dart';
import '../SCREANS/CATEGORIES/categories_screan.dart';
import '../SCREANS/FAVOURITS/favourites_screan.dart';
import '../SCREANS/PRODUCTS/products_screan.dart';
import '../SCREANS/SETINGS/setings_screan.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(App_Initial_State());

  static AppCubit get(context) => BlocProvider.of(context);


  void change_theme()
  {
    is_dark=!is_dark;
    emit(App_theme_state());
  }

  int current_index = 0;

  List<BottomNavigationBarItem> bottomItems = [

    BottomNavigationBarItem(icon: Icon(Icons.production_quantity_limits_sharp), label: 'products'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favorite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
  ];
  List<Widget> screans = [
    Products_screan(),
    Categories_screan(),
    Favourits_screan(),
    Setings_screan(),
  ];

  void changebottomnav(int index) {
    current_index = index;
    emit(App_bottomnav_state());
  }

  Home_Model? homeModel;

  Map <dynamic,dynamic> favorites= {};

  void get_homepage_data() {
    emit(GetHome_loading_state());
    diohelper.getdata(URL:'home', token: token).then((value) {
      homeModel = Home_Model.fromJson(value.data);
      //print(value.data);
      //print(homeModel?.data?.banners?[0].image);
      //print(homeModel?.status);
      homeModel?.data?.products.forEach((element) {
        favorites.addAll({element.id : element.inFavorites,});
      });
      //print(favorites.toString());
      emit(GetHome_success_state());
    }).catchError((error) {
      print(error.toString());
      emit(GetHome_error_state());
    });
  }

  Categories_Model? categoriesModel;
  void get_categories_data() {

    diohelper.getdata(URL:'categories',).then((value) {
      categoriesModel = Categories_Model.fromJson(value.data);

      emit(Categories_success_state());
    }).catchError((error) {
      print(error.toString());
      emit(Categories_error_state());
    });
  }


  Change_Favorites_Model? ChangeFavoritesModel;
  void favorites_change(int? id) {
    favorites[id]=!favorites[id];

    diohelper.postdata(URL:'favorites', data: {'product_id':id},token: token).then((value) {

      ChangeFavoritesModel=Change_Favorites_Model.fromJson(value.data);
      //print(value.data);

      //to get favorites after change
      get_favorites();
      emit(Favorites_success_state());
    }).catchError((error) {
      print(error.toString());
      emit(Favorites_error_state());
    });
  }


  FavoritesModel? favoritesModel;
  void get_favorites() {
    emit(Get_Favorites_loading_state());
    diohelper.getdata(URL:'favorites',token: token).then((value) {

      favoritesModel=FavoritesModel.fromJson(value.data);
      //print(value.data);
      emit(Get_Favorites_success_state());
    }).catchError((error) {
      print(error.toString());
      emit(Get_Favorites_error_state());
    });
  }


  Product_Details? product_details;
  void get_product_details(int? id) {
    emit(Get_Details_loading_state());
    diohelper.getdata(URL:'products/$id',token: token).then((value) {

      product_details=Product_Details.fromJson(value.data);
     // print(value.data);

      emit(Get_Details_success_state());
    }).catchError((error) {
      print(error.toString());
      emit(Get_Details_error_state());
    });
  }


  Login_Model? profileModel;
  void get_user_profile() {
    emit(Get_user_profile_loading_state());
    diohelper.getdata(URL:'profile',token: token).then((value) {

      profileModel=Login_Model.fromJson(value.data);
      //print(value.data);

      emit(Get_user_profile_success_state());
    }).catchError((error) {
      print(error.toString());
      emit(Get_user_profile_error_state());
    });
  }


  Category_Details? categoryDetails;
  void get_category_details(int? id) {
    emit(Get_Category_Details_loading_state());


    diohelper.getdata(URL:'categories/$id').then((value) {

      categoryDetails=Category_Details.fromJson(value.data);
      print(value.data);
      //print(categoryDetails!.data!.productData![43].name);


      emit(Get_Category_Details_success_state());
    }).catchError((error) {
      print(error.toString());
      emit(Get_Category_Details_error_state());
    });
  }



}
