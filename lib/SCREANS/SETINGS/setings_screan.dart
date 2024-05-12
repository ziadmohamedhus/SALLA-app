
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../BLOCK/cubit.dart';
import '../../BLOCK/states.dart';
import '../../COMPONENTS/components.dart';
import '../../COMPONENTS/navigators.dart';
import '../../LOGIN/login.dart';
import '../../MODELS/login-model.dart';
import '../../SHARED-PREFERANCE/shared-pre.dart';

class Setings_screan extends StatelessWidget {

  TextEditingController name_controller=TextEditingController();//password
  TextEditingController email_controller=TextEditingController();//email
  TextEditingController phone_controller=TextEditingController();//password

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
          body: ConditionalBuilder(
              condition: state is! Get_user_profile_loading_state,
              builder: (BuildContext context) =>setings_builder(context,AppCubit.get(context).profileModel),
              fallback: (BuildContext context) =>Center(child: CircularProgressIndicator())),
        );
      },

    );
  }
  Widget setings_builder(context,Login_Model? model)
  {

     name_controller.text=model!.data!.name;//password
     email_controller.text=model.data!.email;//email
     phone_controller.text=model.data!.phone;//

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LOGIN',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),),
            SizedBox(height: 10,),
            Text('login now to browse our hot offers',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 15),),
            SizedBox(height: 30,),
            TextFormField(
              //obscureText: Login_Cubit.get(context).pass,
              keyboardType: TextInputType.text,
              controller: name_controller,
              validator:
                  ( value){
                if (value!.isEmpty) {
                  return'please enter your name';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'user name',
                  hintText: 'Enter your name',
                  prefixIcon: Icon(Icons.person),

                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: email_controller,
              validator:
                  ( value){
                if (value!.isEmpty) {
                  return'please enter your Email';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  hintText: 'Enter your Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  suffixIcon: Icon(Icons.check),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
              ),
            ),
            SizedBox(height: 15.0,),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phone_controller,
              validator:
                  ( value){
                if (value!.isEmpty) {
                  return'please enter your phone';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Phone',
                  hintText: 'Enter your Phone',
                  prefixIcon: Icon(Icons.phone),

                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
              ),
            ),
            SizedBox(height: 25.0,),
            //Submit
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff710019),
                    Color.fromARGB(255, 234, 173, 173)
                  ], // Define your gradient colors here
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0], // Optional: define stops for the gradient
                ),
                borderRadius: BorderRadius.circular(10),


              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: MaterialButton(onPressed: ()
                {
                  Cache_Helper.remove_data(key: 'token').then((value) => Navigator_To_Remove(context,Login()));
                },child: Text('LOGOUT',style: TextStyle(fontSize: 30,color: Colors.white),),),
              ),
            ),

            SizedBox(height: 10.0,),



          ],
        ),
      ),
    );
  }
}
//ConditionalBuilder()