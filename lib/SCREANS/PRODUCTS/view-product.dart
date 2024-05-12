
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/BLOCK/cubit.dart';
import 'package:store_app/BLOCK/states.dart';

import '../../COMPONENTS/components.dart';
import '../../MODELS/product-details-model.dart';

class View_product extends StatefulWidget {

  @override
  State<View_product> createState() => _View_productState();
}

class _View_productState extends State<View_product>with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAniimation1;
  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
  }

  @override
  void dispose() {
    animationController.dispose(); // Dispose of the animation controller
    super.dispose();
    }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: state is! Get_Details_loading_state,
          builder: (BuildContext context) =>Page_content(context,AppCubit.get(context).product_details,),
          fallback: (BuildContext context) =>Center(child: CircularProgressIndicator(color: color,)),
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
      appBar: AppBar(title: Text('SALLA',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),centerTitle: true,),
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
              AnimatedBuilder(
                animation: slidingAniimation1,
                builder: (context, _) =>
                 SlideTransition(
                  position: slidingAniimation1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price: \$${model.data!.price}',style: TextStyle(color:Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold,)),
                      Text('Old Price: \$${model.data!.oldPrice}',style: TextStyle(color:Colors.red,fontSize: 20.0,fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                ),
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

  void initSlidingAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    slidingAniimation1 =
        Tween<Offset>(begin: const Offset(8, 0), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
    }
}
