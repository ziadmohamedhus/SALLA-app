
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/BLOCK/cubit.dart';
import 'package:store_app/BLOCK/states.dart';
import 'package:store_app/COMPONENTS/navigators.dart';
import 'package:store_app/MODELS/categories-model.dart';

import 'categories-details.dart';

class Categories_screan extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(AppCubit.get(context).categoriesModel!.data!.data[index],context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: AppCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget buildCatItem(Data_Model model,context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: GestureDetector(
      onTap: (){
        AppCubit.get(context).get_category_details(model.id);
        Navigator_To(context, Categories_Details());
      },
      child: Row(
        children:
        [
          Image(
            image: NetworkImage(model.image.toString()),
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            model.name.toString(),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
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
