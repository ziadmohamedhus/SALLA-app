


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../BLOCK/cubit.dart';
import '../../BLOCK/states.dart';
import '../../MODELS/categories-details-model.dart';

class Categories_Details extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return Scaffold(
          appBar: AppBar(title: Text('SALLA',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
          body: ConditionalBuilder(
            condition: state is! Get_Category_Details_loading_state,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListProducts(AppCubit.get(context).categoryDetails!.data!.productData![index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: AppCubit.get(context).categoryDetails!.data!.productData!.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildListProducts(ProductsDatas? model,) =>
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
}
