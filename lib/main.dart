import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/BLOCK/cubit.dart';
import 'package:store_app/COMPONENTS/components.dart';
import 'package:store_app/DIO/dio-helper.dart';
import 'package:store_app/LOGIN/login.dart';
import 'package:store_app/SCREANS/home-page.dart';
import 'package:store_app/SHARED-PREFERANCE/shared-pre.dart';

import 'ON-BOARDING/on_Boarding_screan.dart';

void main()async {
  //if you make main async
  WidgetsFlutterBinding.ensureInitialized();
  diohelper.init();
  await Cache_Helper.init();
  bool? onBoarding_Finish= await Cache_Helper.get_data(key: 'onBoarding_Finish');
  token= await Cache_Helper.get_data(key: 'token');
  print(token);

  Widget widget;
  if(onBoarding_Finish!=null)
    {
      if(token!=null)widget=Home_page();
      else widget=Login();
    }
  else{ widget=On_BordinBoarding(); }




  runApp( MyApp(widget: widget,));
}
class MyApp extends StatelessWidget {


   MyApp({ required this.widget});
   Widget widget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) { return AppCubit()..get_homepage_data()..get_categories_data()..get_favorites()..get_user_profile(); },
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: AppCubit.get(context).is_dark?ThemeMode.dark:ThemeMode.light,
        //theme: ThemeData(bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedItemColor: Color(0xff710019)),floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Color(0xff710019))),
        debugShowCheckedModeBanner: false,
        home: widget,
      ),
    );
  }
}
//ThemeData(
//         fontFamily: "rubik",
//         primarySwatch: Colors.blue,
//       ),
