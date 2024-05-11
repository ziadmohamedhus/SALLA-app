
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_app/COMPONENTS/components.dart';
import 'package:store_app/COMPONENTS/navigators.dart';
import 'package:store_app/LOGIN/BLOCK/login-cubit.dart';
import 'package:store_app/LOGIN/BLOCK/login-states.dart';
import 'package:store_app/SCREANS/home-page.dart';
import 'package:store_app/SHARED-PREFERANCE/shared-pre.dart';

import '../REGISTER/register.dart';
import 'custom_painter.dart';

class Login extends StatelessWidget {
   Login({Key? key}) : super(key: key);
  TextEditingController email_controller=TextEditingController();//email
  TextEditingController password_controller=TextEditingController();//password
   var Submit_Key = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>Login_Cubit(),
      child: BlocConsumer<Login_Cubit,Login_States>(

        listener: (BuildContext context, Object? state) {
          if(state is Login_Success_State)
            {
              if(state.logimodel.status)
                {
                  Cache_Helper.save_data(key: 'token', value: state.logimodel.data?.token).then((value) {
                    token=state.logimodel.data?.token;
                    Navigator_To_Remove(context, Home_page());
                  });

                  Fluttertoast.showToast(
                      msg: '${state.logimodel.message}',
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
                      msg: '${state.logimodel.message}',
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
                              'Login',
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
                            suffixIcon: Icon(Icons.check),
                             prefixIconColor: color,
                            suffixIconColor: color,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: textFormBorder(),
                          enabledBorder: textFormBorder(),
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      TextFormField(
                        obscureText: Login_Cubit.get(context).pass,
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
                            labelStyle: TextStyle(color: Color(0xff710019)),
                            hintText: 'Enter your Password',
                            hintStyle: TextStyle(color: Color(0xff710019)),
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                          prefixIconColor: color,
                          suffixIconColor: color,
                            suffixIcon: IconButton(onPressed: (){
                              Login_Cubit.get(context).Change_icon_password();

                              }, icon: Icon(Login_Cubit.get(context).suffix),),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: textFormBorder(),
                          enabledBorder: textFormBorder(),
                        ),
                      ),
                      SizedBox(height: 25.0,),
                      //Submit
                      if(state is! Login_Loding_State)
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
                              Login_Cubit.get(context).Login_function(email: email_controller.text, password: password_controller.text);


                            }
                          },child: Text('SUBMIT',style: TextStyle(fontSize: 30,color: Colors.white),),),
                        ),
                      )
                      else
                        Center(child: CircularProgressIndicator()),


                      SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator_To(context, Register_screan());
                            },
                            child: Text(
                              'Register Now',
                              style: TextStyle(color: Color(0xff710019)),
                            ),
                          ),
                        ],
                      ),


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
