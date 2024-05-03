
import 'package:dio/dio.dart';

class diohelper
{
  static late Dio dio;
  static init()
  {
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type':'application/json',
          'lang':'ar'
        },
      ),
    );
  }
  static  Future getdata({required String URL, dynamic query,lang='en',String? token})async
  {
    dio.options.headers= {
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization':token,
    };
    return await dio.get(URL,queryParameters:query );
  }

  static  Future postdata({required String URL, dynamic query,required Map<String,dynamic>data,lang='en',token})async
  {
    dio.options.headers= {
        'lang':lang,
        'Content-Type':'application/json',
        'Authorization':token,
      };
    return await dio.post(URL,queryParameters:query,data: data );
  }
}