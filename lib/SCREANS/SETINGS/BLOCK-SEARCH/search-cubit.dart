import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/SCREANS/SETINGS/BLOCK-SEARCH/search-states.dart';

import '../../../COMPONENTS/components.dart';
import '../../../MODELS/product-details-model.dart';
import '../../../MODELS/search-model.dart';
import 'package:store_app/DIO/dio-helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(Search_Initial_State());

  static SearchCubit get(context) => BlocProvider.of(context);


  Search_Model? SearchModel;
  void search_function(text) {
    emit(Search_loading_state());

    diohelper.postdata(URL:'products/search', data: {'text':text},token: token).then((value) {

      SearchModel=Search_Model.fromJson(value.data);
      //print(value.data);


      emit(Search_success_state());
    }).catchError((error) {
      print(error.toString());
      emit(Search_error_state());
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
}