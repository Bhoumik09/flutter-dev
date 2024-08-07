import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/auth/screens/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth_screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService=AuthService();
  // just registering the auth service 
  @override
  void dispose() {
    super.dispose();
    // to prevents leak we have to write the next lines
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    
  }
  void signUpUser(){
    authService.signUpUser(context: context, email: _emailController.text, password: _passwordController.text, name: _nameController.text);
  }

  // auth.signup will be defualt
  // fro group value we are initizalizing enum Auth _auth
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Welcome ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            ListTile(
              tileColor: _auth==Auth.signup?GlobalVariables.backgroundColor:GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Create Account ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signup)
              Container(
                padding:const  EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signupFormKey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        controller: _nameController,
                        hintText: "Name",
                      ),
                      const SizedBox(height: 10,),
                      CustomTextfield(
                        controller: _emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(height:10),
                      CustomTextfield(
                        controller: _passwordController,
                        hintText: "Password",
                        obscureText: true,
                      ),
                      const SizedBox(height: 10,),
                      CustomButton(text: "SignUp", onTap:(){
                        if(_signupFormKey.currentState!.validate()){
                          signUpUser();
                        }
                      } )
                    ],
                  ),
                ),
              ),
            ListTile(
              tileColor: _auth==Auth.signin?GlobalVariables.backgroundColor:GlobalVariables.greyBackgroundCOlor,

              title: const Text(
                "Sign In",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signin)
              Container(
                padding:const  EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signinFormKey,
                  child: Column(
                    children: [
                      
                      CustomTextfield(
                        controller: _emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(height:10),
                      CustomTextfield(
                        controller: _passwordController,
                        hintText: "Password",
                        obscureText: true,
                      ),
                      const SizedBox(height: 10,),
                      CustomButton(text: "SignUp", onTap:(){} )
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
