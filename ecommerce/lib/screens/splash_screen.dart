import 'package:ecommerce/constants/helper_functions.dart';
import 'package:ecommerce/screens/product_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nextScreen();
    
  }


  nextScreen(){
    Future.delayed(Duration(seconds: 2)).then((value) {
      replaceScreen(context: context, screen: ProductScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: 
    Text("Ecommerce"),),);
  }
}