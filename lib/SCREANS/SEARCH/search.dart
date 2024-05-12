
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/COMPONENTS/components.dart';
import 'package:store_app/COMPONENTS/navigators.dart';

import '../../MODELS/search-model.dart';
import '../PRODUCTS/view-product.dart';
import '../SETINGS/BLOCK-SEARCH/search-cubit.dart';
import '../SETINGS/BLOCK-SEARCH/search-states.dart';

class Search_screan extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context) =>SearchCubit(),
        child: BlocConsumer<SearchCubit,SearchStates>(
            listener: (BuildContext context, state) {  },
            builder: (BuildContext context, Object? state) {
              return Scaffold(
                appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
                body: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: searchController,
                      onFieldSubmitted: (text){
                        SearchCubit.get(context).search_function(text);
                      },
                      validator:
                          ( value){
                        if (value!.isEmpty) {
                          return'please enter text to search';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'SEARCH',
                          hintText: 'Enter your text',
                        labelStyle: TextStyle(color: Color(0xff710019)),
                        hintStyle: TextStyle(color: Color(0xff710019)),
                          prefixIcon: Icon(Icons.search),
                        prefixIconColor: color,
                        suffixIconColor: color,
                        focusedBorder: textFormBorder(),
                          //suffixIcon: Icon(Icons.check),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: color)),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    if (state is Search_loading_state) LinearProgressIndicator(),
                    SizedBox(height: 10.0,),
                    if (state is Search_success_state)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProducts(
                            SearchCubit.get(context).SearchModel!.data!.data[index],context

                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount:
                          SearchCubit.get(context).SearchModel!.data!.data.length,
                        ),
                      ),
                  ],
                ),
              );
            },

        ));
  }

  Widget buildListProducts(Product? model,context) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model!.image.toString()),
                    width: 120.0,
                    height: 120.0,
                  ),
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '\$${model.price.toString()}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          '\$${model.oldPrice.toString()}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget myDivider() => Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 20.0,
    ),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  );

  OutlineInputBorder textFormBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        borderSide: BorderSide(
          color: Color(0xff710019),
        ));
  }
}
