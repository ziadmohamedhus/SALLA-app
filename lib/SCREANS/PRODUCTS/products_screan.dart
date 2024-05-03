
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/BLOCK/cubit.dart';
import 'package:store_app/BLOCK/states.dart';
import 'package:store_app/MODELS/categories-model.dart';
import 'package:store_app/MODELS/home-model.dart';
import 'package:store_app/SCREANS/PRODUCTS/view-product.dart';

import '../../COMPONENTS/navigators.dart';
import '../CATEGORIES/categories-details.dart';

class Products_screan extends StatelessWidget {
  const Products_screan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, Object? state) {  },
        builder: (BuildContext context, state) {
          return  ConditionalBuilder(
              condition: AppCubit.get(context).homeModel != null && AppCubit.get(context).categoriesModel != null,
              builder: (context)=> Home_builder(AppCubit.get(context).homeModel,AppCubit.get(context).categoriesModel,context),
              fallback: (context)=>Center(child: CircularProgressIndicator()) );
        },

    );
  }

  Widget Home_builder(Home_Model? model,Categories_Model? categories_Model,context)
  {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Animation
          CarouselSlider(
              items: model?.data?.banners.map((e) =>Image(
                image: NetworkImage(e.image.toString()),
                width: double.infinity,
                fit: BoxFit.cover,
              ), ).toList(),
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
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        GestureDetector(
                          onTap: (){
                            AppCubit.get(context).get_category_details(categories_Model.data!.data[index].id);
                            Navigator_To(context, Categories_Details());
                          },
                            child: buildCategoryItem(categories_Model.data!.data[index])),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10.0,
                    ),
                    itemCount: categories_Model!.data!.data.length,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          //items
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 1/1.70,
                children: List.generate(
                        model!.data!.products.length,
                        (index) => Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            GestureDetector(
                              onTap: (){
                                AppCubit.get(context).get_product_details(model.data!.products[index].id);
                                Navigator_To(context,View_product());
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Image(
                                      image: NetworkImage(model.data!.products[index].image.toString()),
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                  if(model.data!.products[index].discount!=0)
                                  Container(
                                    color: Colors.red,
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Text('DISCOUNT',style: TextStyle(color: Colors.white,fontSize: 13),),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.data!.products[index].name.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(height: 1.3),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${model.data!.products[index].price}\$',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(height: 1.3,fontSize: 12,color: Colors.blue),
                                      ),
                                      SizedBox(width: 5,),
                                      if(model.data!.products[index].discount!=0)
                                      Text(
                                        '${model.data!.products[index].oldPrice}\$',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            height: 1.3,
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                            decoration: TextDecoration.lineThrough
                                        ),

                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: (){
                                            AppCubit.get(context).favorites_change(model.data!.products[index].id);
                                          },
                                          icon: Icon(
                                              Icons.favorite,
                                            color:AppCubit.get(context).favorites[model.data!.products[index].id] ?Colors.red:Colors.grey[400],

                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],),
                        )
                ),

            ),
          )

        ],
      ),
    );

  }
  Widget buildCategoryItem(Data_Model model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image.toString()),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(
          .8,
        ),
        width: 100.0,
        child: Text(
          model.name.toString(),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
