
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/BLOCK/cubit.dart';
import 'package:store_app/BLOCK/states.dart';
import 'package:store_app/COMPONENTS/navigators.dart';
import 'package:store_app/LOGIN/login.dart';
import 'package:store_app/SHARED-PREFERANCE/shared-pre.dart';

import 'SEARCH/search.dart';

class Home_page extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state) {

        var cubit=AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title:Text('SALLA',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
            centerTitle: true,
            //backgroundColor: Colors.transparent,elevation: 0,
            actions: [
              IconButton(onPressed: (){
              Navigator_To(context, Search_screan());
            }, icon: Icon(Icons.search,color: Colors.black,),),

              IconButton(onPressed: (){
              AppCubit.get(context).change_theme();
            }, icon: Icon(Icons.sunny_snowing,color: Colors.black,),),
              ],
          ),
          body:cubit.screans[cubit.current_index],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.current_index,
            onTap: (index)
            {
              cubit.changebottomnav(index);
            },
            items: cubit.bottomItems,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
          ),

        );
      },

    );
  }
}


//TextButton(child:Text('logout'),onPressed:(){
//             Cache_Helper.remove_data(key: 'token').then((value) => Navigator_To_Remove(context,Login()));
//           } ,),
