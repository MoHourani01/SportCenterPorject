import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_center_project/Screens/MainNavBar/main_navigation_bar.dart';
import 'package:sport_center_project/Utilities/Services/connectivity_service.dart';
import 'package:sport_center_project/Utilities/VariablesUtils.dart';
import 'package:sport_center_project/registration/UserService/user_service.dart';
import 'package:sport_center_project/registration/login/login_cubit/login_cubit.dart';
import 'package:sport_center_project/registration/login/login_cubit/login_states.dart';
import 'package:sport_center_project/registration/register/register_screen.dart';
import 'package:sport_center_project/shared/component/component.dart';
import 'package:sport_center_project/shared/network/internet_connection_dialog.dart';
import 'package:sport_center_project/shared/network/loader.dart';
import 'package:sport_center_project/shared/network/local/cache_helper.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  // const LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors:[Colors.black,Colors.black38],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(bounds),blendMode: BlendMode.srcOver,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/login2.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black26,
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  height: 500,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFD040842).withOpacity(0.9)),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Text(
                            'Welcome to Sport Center',
                            style: TextStyle(color: Colors.black54, fontSize: 17.0),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultLoginFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            hintText: 'Email Address',
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return'please enter email address!';
                              }
                              return null;
                            },
                            prefix: Icons.email_outlined,
                            // backgroundHintColor: Colors.white,
                            prefixIconColor: Color(0xFD040842),
                            // hintStyleColor: Colors.black26,
                            labelText: 'Email Address',
                            labilStyleColor: Color(0xFD040842),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultLoginFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              hintText: 'Password',
                              prefix: Icons.lock_outline,
                              suffixIconColor: Color(0xFD040842),
                              suffix: showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              isPassword: showPassword,
                              suffixPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                                // model.changePasswordVisibilty();
                              },
                              validate: (String? value)
                              {
                                if(value!.isEmpty)
                                {
                                  return'please enter Password!';
                                }
                                return null;
                              },
                              onChanged: (value){
                                passwordController=value;
                              },
                              prefixIconColor: Color(0xFD040842),
                              // hintStyleColor: Colors.black26,
                              // backgroundHintColor: Color(0xFCF8D2E7),
                              labelText: 'Password',
                              labilStyleColor: Color(0xFD040842),
                              // onSubmit: (value){
                              //   if(formKey.currentState!.validate()){
                              //     model.userLogin(
                              //         emailController.text,
                              //         passwordController.text);
                              //   }
                              // }
                          ),
                          defaultTextButton(
                            function: (){},
                            text: 'Forget Password?',
                            textButtonColor: Color(0xFD040842),
                            fontSize: 13.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultLoginButton(
                            width: double.infinity,
                            //backround: Colors.blue,
                            function: () {
                              validateAndSubmit(context);
                              print("Email: ${emailController.text}, Password: ${passwordController.text}");
                              // if (formKey.currentState!.validate()){
                              //   LoginCubit.get(context).userLogin(emailController.text, passwordController.text);
                              //   showToast(text: 'Login Success', state: ToastStates.Success);
                              //   // navigators.navigateTo(context, MainNavigationBar());
                              // }
                              // else if(passwordController.text.isEmpty && emailController.text.isEmpty){
                              //   showToast(text: 'Login Failed', state: ToastStates.Error);
                              // }
                              // else if(emailController.text.isEmpty && passwordController.text.isNotEmpty){
                              //   showToast(text: 'Please enter your email address', state: ToastStates.Warning);
                              // }
                              // else if(emailController.text.isNotEmpty && passwordController.text.isEmpty){
                              //   showToast(text: 'Please enter your password', state: ToastStates.Warning);
                              // }
                              // else{
                              //   showToast(text: 'Login Failed', state: ToastStates.Error);
                              // }
                              // else{
                              //   Fluttertoast.showToast(msg: 'Login failed');
                              // }
                              // navigators.navigateTo(context, MainNavigationBar());
                            },
                            text: 'LOGIN',
                            radius: 8.0,
                            backround: Color(0xFD040842),
                            textButtonColor: Colors.white,
                            fontSize: 18.0,
                          ),

                          SizedBox(height: 12.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              defaultTextButton(
                                function: () {
                                  navigators.navigateTo(context, RegisterScreen());
                                },
                                text: 'sign-up',
                                textButtonColor: Color(0xFD040842),
                                fontSize: 16.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateAndSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if(await ConnectivityService.checkInternetConnectivity()){
        Loader.showLoadingScreen(context, _keyLoader);
        log('email : ${emailController.text.trim()} | password : ${passwordController.text.trim()}');
        var result = await LoginCubit.get(context).userLogin(
            emailController.text.trim(), passwordController.text.trim());
        Navigator.of(_keyLoader.currentContext ?? context, rootNavigator: true)
            .pop();
        if (result == 'No user found for that email.') {
          showToast(text: result, state: ToastStates.Warning);
        } else if (result == 'Wrong password provided for that user.') {
          showToast(text: result, state: ToastStates.Warning);
        } else if (result == "This isn't an email") {
          showToast(text: result, state: ToastStates.Warning);
        } else if (result.isEmpty) {
          showToast(text: 'Enter your email and password', state: ToastStates.Error);
        } else {
          showToast(text: 'Login Successfully', state: ToastStates.Success);
          saveUserData(result);
        }
      }
    }
  }

  saveUserData(String uid) async {
    try {
      var value = await LoginCubit.get(context).getUser(uid);
      VariablesUtils.uid = value?.uId ?? '';
      VariablesUtils.userName = value?.name ?? '';
      VariablesUtils.email = value?.email ?? '';
      VariablesUtils.phone = value?.phone ?? '';
      VariablesUtils.password = value?.password ?? '';
      VariablesUtils.imageUrl = value?.image ?? '';

      // Store the values in SharedPreferences
      VariablesUtils.prefs = await SharedPreferences.getInstance();
      VariablesUtils.prefs.setString('uid', VariablesUtils.uid);
      VariablesUtils.prefs.setString('name', VariablesUtils.userName);
      VariablesUtils.prefs.setString('email', VariablesUtils.email);
      VariablesUtils.prefs.setString('phone', VariablesUtils.phone);
      VariablesUtils.prefs.setString('password', VariablesUtils.password);
      VariablesUtils.prefs.setString('imageUrl', VariablesUtils.imageUrl);

      navigators.navigateTo(context, MainNavigationBar());
    } catch (e) {
      // Handle the case where an exception is thrown.
      print('Error saving user data: $e');
    }
  }
}
