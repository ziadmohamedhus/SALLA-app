
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_app/COMPONENTS/components.dart';
import 'package:store_app/COMPONENTS/navigators.dart';
import 'package:store_app/REGISTER/BLOC/cubit.dart';
import 'package:store_app/SCREANS/home-page.dart';
import 'package:store_app/SHARED-PREFERANCE/shared-pre.dart';

import '../LOGIN/custom_painter.dart';
import 'BLOC/states.dart';

class Register_screan extends StatelessWidget {

  TextEditingController name_controller=TextEditingController();//email
  TextEditingController email_controller=TextEditingController();
  TextEditingController phone_controller=TextEditingController();
  TextEditingController password_controller=TextEditingController();//password
  var Submit_Key = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>Register_Cubit(),
      child: BlocConsumer<Register_Cubit,ShopRegisterStates>(

        listener: (BuildContext context, Object? state) {
          if(state is ShopRegisterSuccessState)
          {
            if(state.loginModel!.status)
            {
              Cache_Helper.save_data(key: 'token', value: state.loginModel!.data?.token).then((value) {
                token=state.loginModel!.data?.token;
                Navigator_To_Remove(context, Home_page());
             });

              Fluttertoast.showToast(
                  msg: '${state.loginModel!.message}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
            else
            {
              Fluttertoast.showToast(
                  msg: '${state.loginModel!.message}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }


          }
        },



        builder: (BuildContext context, state) { return  Scaffold(
          //appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
          body: Form(
            key: Submit_Key,
            child: SingleChildScrollView(
              child: CustomPaint(
                painter: MyCustomPainter(height: 810),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 150,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Register',
                            style: TextStyle(
                              //fontFamily: Kprimaryfont,
                                fontSize: 55,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Welcome our app',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                //fontFamily: Kprimaryfont,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(height: 130,),
                      TextFormField(
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
                            labelText: 'NAME',
                            hintText: 'Enter your name',
                            prefixIcon: Icon(Icons.person),
                          prefixIconColor: color,
                          suffixIconColor: color,
                            //suffixIcon: Icon(Icons.check),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: textFormBorder(),
                          //enabledBorder: textFormBorder(),
                        ),
                      ),
                      SizedBox(height: 15.0,),
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
                          labelStyle: TextStyle(color: Color(0xff710019)),
                          hintStyle: TextStyle(color: Color(0xff710019)),
                            prefixIcon: Icon(Icons.email_outlined),
                          prefixIconColor: color,
                          suffixIconColor: color,
                            suffixIcon: Icon(Icons.check),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: textFormBorder(),
                          //enabledBorder: textFormBorder(),
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      TextFormField(
                        obscureText: Register_Cubit.get(context).isPassword,
                        keyboardType: TextInputType.text,
                        controller: password_controller,
                        validator:
                            ( value){
                          if (value!.isEmpty) {
                            return'please enter your Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your Password',
                          labelStyle: TextStyle(color: Color(0xff710019)),
                          hintStyle: TextStyle(color: Color(0xff710019)),
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                          prefixIconColor: color,
                          suffixIconColor: color,
                            suffixIcon: IconButton(onPressed: (){
                              Register_Cubit.get(context).changePasswordVisibility();

                            }, icon: Icon(Register_Cubit.get(context).suffix),),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: textFormBorder(),
                          //enabledBorder: textFormBorder(),
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
                            labelText: 'PHONE',
                            hintText: 'Enter your phone',
                          labelStyle: TextStyle(color: Color(0xff710019)),
                          hintStyle: TextStyle(color: Color(0xff710019)),
                            prefixIcon: Icon(Icons.phone),
                          prefixIconColor: color,
                          suffixIconColor: color,

                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: textFormBorder(),
                          //enabledBorder: textFormBorder(),
                        ),
                      ),
                      SizedBox(height: 25.0,),
                      //Submit
                      if(state is! ShopRegisterLoadingState)
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
                              if (Submit_Key.currentState!.validate())
                              {
                                Register_Cubit.get(context).userRegister(name: name_controller.text, email: email_controller.text, password: password_controller.text, phone: phone_controller.text);


                              }
                            },child: Text('SUBMIT',style: TextStyle(fontSize: 30,color: Colors.white),),),
                          ),
                        )
                      else
                        Center(child: CircularProgressIndicator()),





                    ],
                  ),
                ),
              ),
            ),
          ),
        );},

      ),
    );
  }
  OutlineInputBorder textFormBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        borderSide: BorderSide(
          color: Color(0xff710019),
        ));
  }
}
