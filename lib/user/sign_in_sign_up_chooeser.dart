import 'package:dine_dash/colors.dart';
import 'package:dine_dash/commonWidgets.dart';
import 'package:flutter/material.dart';

class SignInSignUpChooeser extends StatefulWidget {
  const SignInSignUpChooeser({super.key});

  @override
  State<SignInSignUpChooeser> createState() => _SignInSignUpChooeserState();
}

class _SignInSignUpChooeserState extends State<SignInSignUpChooeser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/Register.png",colorBlendMode: BlendMode.multiply,color: Colors.black45,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              commonText("Welcome!",size: 21,isBold: true,color: AppColors.white),
              SizedBox(height: 16,),
              commonText("Now continue after register in “DEALR”.",size: 14,color: AppColors.white),
              commonButton("Sign In"),

            SizedBox(height: 16,),
            commonBorderButton("Sign Up",color: Colors.transparent)
            ],),
          )
        ],
      ),
    );
  }
}