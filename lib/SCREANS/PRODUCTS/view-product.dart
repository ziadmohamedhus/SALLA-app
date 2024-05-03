
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/BLOCK/cubit.dart';
import 'package:store_app/BLOCK/states.dart';

import '../../MODELS/product-details-model.dart';

class View_product extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: state is! Get_Details_loading_state,
          builder: (BuildContext context) =>Page_content(context,AppCubit.get(context).product_details,),
          fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),
        );
      },

    );
  }
  Widget Page_content(context,Product_Details? model)
  {
    List<Image> images=[];
    for(int i=0;i<model!.data!.images!.length;i++)
      {
        images.add(Image.network(model.data!.images![i]));
      }
    return Scaffold(
      appBar: AppBar(title: Text('SALLA',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [
              SizedBox(height: 35,),
              CircleAvatar(

                  backgroundImage: NetworkImage(model.data!.image.toString()),
                  radius: 100.0,
                ),

              SizedBox(height: 20,),
              Text('Name: ${model.data!.name}  ',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price: \$${model.data!.price}',style: TextStyle(color:Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold,)),
                  Text('Old Price: \$${model.data!.oldPrice}',style: TextStyle(color:Colors.red,fontSize: 20.0,fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough)),
                ],
              ),

              // Animation
              CarouselSlider(
                  items:images ,
                  options: CarouselOptions(
                      height: 250,
                      enableInfiniteScroll: true,
                      initialPage: 0,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(seconds:1),
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                      scrollDirection: Axis.horizontal,
                      viewportFraction: 1
                  )),
              SizedBox(height: 25,),
              Text('Description',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,),),
              SizedBox(height: 10,),
              Text('${model.data!.description}',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: Colors.grey)),
              SizedBox(height: 10,),

              // Text('Specification : ',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,)),
              // SizedBox(height: 10,),
              // Text('Experience :  ',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,)),
              // SizedBox(height: 10,),
              // Text('The Salary :\$500',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,)),
            ],
          ),
        ),
      ),
    );
  }
}
