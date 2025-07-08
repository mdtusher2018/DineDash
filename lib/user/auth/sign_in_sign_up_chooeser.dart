import 'package:dine_dash/colors.dart';
import 'package:dine_dash/commonWidgets.dart';
import 'package:dine_dash/image_paths.dart';
import 'package:dine_dash/user/auth/create_user_account.dart';
import 'package:dine_dash/user/auth/sign_in_page.dart';
import 'package:flutter/material.dart';

class UserSignInSignUpChooeser extends StatefulWidget {
  const UserSignInSignUpChooeser({super.key});

  @override
  State<UserSignInSignUpChooeser> createState() => _UserSignInSignUpChooeserState();
}

class _UserSignInSignUpChooeserState extends State<UserSignInSignUpChooeser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
                fit: StackFit.expand,
        children: [
          Image.asset("assets/images/Register.png",colorBlendMode: BlendMode.multiply,color: Colors.black45,fit: BoxFit.cover,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(),
                Center(child: Image.asset(ImagePaths.logo)),
                Spacer(flex: 5,),
              commonText("Welcome!",size: 21,isBold: true,color: AppColors.white),
              SizedBox(height: 20,),
              commonText("Now continue after register in \"DEALR\".",size: 14,color: AppColors.white),
                SizedBox(height: 20,),commonButton("Sign In",onTap: () {
                  navigateToPage(UserSignInScreen());
                },),

            SizedBox(height: 20,),
            commonBorderButton("Sign Up",textColor: AppColors.white,onTap: () {
              navigateToPage(CreateUserAccount());
            },),  SizedBox(height: 40,),
            ],),
          )
        ],
      ),
    );
  }
}