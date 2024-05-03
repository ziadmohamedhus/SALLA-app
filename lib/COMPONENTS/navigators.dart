import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void Navigator_To(context,widget)
{
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

void Navigator_To_Remove(context,widget)
{
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget),(route) => false,);
}
