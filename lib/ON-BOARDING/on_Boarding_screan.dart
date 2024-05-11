
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_app/COMPONENTS/navigators.dart';
import 'package:store_app/LOGIN/login.dart';
import 'package:store_app/SHARED-PREFERANCE/shared-pre.dart';

import '../COMPONENTS/components.dart';

class On_BordinBoarding extends StatefulWidget {


  @override
  State<On_BordinBoarding> createState() => _On_BordinBoardingState();
}

class _On_BordinBoardingState extends State<On_BordinBoarding> {
  List<Boarding_model> Boarding_list=[
    Boarding_model(image: 'https://lottie.host/0a395547-5484-4006-9159-db2280edf326/mEY9XLlB86.json',title: 'First page',body: 'First page'),
    Boarding_model(image: 'https://lottie.host/a4d4601e-28db-4ab7-8b73-cb0dbd1cfe95/yEStIKauuW.json',title: 'Second page',body: 'Second page'),
    Boarding_model(image: 'https://lottie.host/55ef5a0a-b143-482a-9ba7-a095d3c94094/3SKdpEp04u.json',title: 'third page',body: 'third page'),
  ];

  var Boarding_controler=PageController();

  bool is_last=false;
  int ind = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
          leading: Row(
            children: [
            SizedBox(
            width: 2,
          ),
          Text(
            "${ind}",
            style: TextStyle(color: color),
          ),
          Text("/3",style: TextStyle(color: Colors.black),),
          ],
      ),
        elevation: 0,
        actions: [
          TextButton(onPressed: (){

            //to display the first pages in the first use only==============================

            Cache_Helper.save_data(
                key: 'onBoarding_Finish',
                value: true).then((value)
                   {
                     if(value)
                       {
                         Navigator_To_Remove(context, Login());
                       }
                   });
            },
              child: Text('SKIP',style: TextStyle(color: color),))],),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context,index)=>Build_boarding_item(Boarding_list[index]),
                itemCount: Boarding_list.length,
                //to controlling the pages
                controller: Boarding_controler,
                //to remove shadow after first and last page
                physics: BouncingScrollPhysics(),
                onPageChanged: (index){
                  setState(() {
                    ind = index + 1;
                    });
                  if(index==Boarding_list.length-1)
                    {
                      is_last=true;
                      setState(() {});
                    }
                },

              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                //  the points under the photo...
                SmoothPageIndicator(
                    controller: Boarding_controler,
                    count: Boarding_list.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Color(0xff710019),
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4,
                    ),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Color(0xff710019),
                  onPressed: (){
                    if(is_last==true)
                      {
                        //to display the first pages in the first use only==============================

                        Cache_Helper.save_data(
                            key: 'onBoarding_Finish',
                            value: true).then((value)
                        {
                          if(value)
                          {
                            Navigator_To_Remove(context, Login());
                          }
                        });
                      }
                    else
                        {
                          Boarding_controler.nextPage(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn
                        );}

                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget Build_boarding_item(Boarding_model model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 100,),
      Expanded(child: Container( child: Lottie.network(model.image))),
      SizedBox(height: 20,),
      Text(model.title,style: TextStyle(fontSize: 24,fontFamily: 'rubik',fontWeight: FontWeight.bold),),
      SizedBox(height: 15,),
      Text(model.body,style: TextStyle(fontSize: 14,fontFamily: 'rubik',fontWeight: FontWeight.bold),),

    ],
  );
}
class Boarding_model
{
  final String image;
  final String title;
  final String body;
  Boarding_model({required this.image,required this.title,required this.body});
}
