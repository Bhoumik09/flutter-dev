
import 'package:amazon_self/common/custom_button.dart';
import 'package:amazon_self/common/custom_text_field.dart';
import 'package:amazon_self/constants/global_variables.dart';
import 'package:amazon_self/features/auth/screen/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _signupFormKey=GlobalKey<FormState>();
  final _signinFormKey=GlobalKey<FormState>();
  final AuthService authService=AuthService();
  Auth _auth = Auth.signup;
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  void signUpUser(){
    authService.signUpUser(context: context, name: _nameController.text, email: _emailController.text, password: _passwordController.text);
  }
  void signInUser(){
    authService.signInUser(context: context, email: _emailController.text, password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                title: const Text(
                  'Signup',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    }),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signupFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            hintText: 'Name', controller: _nameController),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: 'Email',
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            obscureText: true,
                            hintText: 'Password',
                            controller: _passwordController,),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(onTap: (){
                          if(_signupFormKey.currentState!.validate()){
                          signUpUser();
                        }
                        }, text: "SignUp"),
                      ],
                    ),
                  ),
                  
                ),
                ListTile(
                title: const Text(
                  'Sign in',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    }),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signinFormKey,
                    child: Column(
                      children: [
                        
                        CustomTextField(
                          hintText: 'Email',
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            hintText: 'Password',
                            controller: _passwordController,
                            obscureText: true,
                            ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(onTap: (){
                          if(_signinFormKey.currentState!.validate()){
                            signInUser();
                          }
                        }, text: 'SignIn')

                      ],
                    ),
                  ),
                  
                )
            ],
          ),
        ),
      ),
    );
  }
}
