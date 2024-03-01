import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

openScreen({required BuildContext context, required screen}){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>screen));
}

replaceScreen({required BuildContext context, required screen}){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>screen));
}
closeScreen({required BuildContext context}){
  Navigator.pop(context);}
