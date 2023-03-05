import 'package:flutter/material.dart';
import 'package:sport_center_project/registration/login/login_screen.dart';
import 'package:sport_center_project/shared/component/component.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // const RegisterScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var userController = TextEditingController();

  var phoneController = TextEditingController();

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
              ).createShader(bounds),blendMode: BlendMode.darken,
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
                  height: 550,
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
                            'SignUp',
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
                            controller: userController,
                            type: TextInputType.text,
                            hintText: 'Username',
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your username';
                              }
                            },
                            prefix: Icons.person,
                            // backgroundHintColor: Colors.white,
                            prefixIconColor: Color(0xFD040842),
                            // hintStyleColor: Colors.black26,
                            labelText: 'Username',
                            labilStyleColor: Color(0xFD040842),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultLoginFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            hintText: 'Email Address',
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email address';
                              }
                            },
                            prefix: Icons.email,
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
                            prefix: Icons.lock,
                            suffixIconColor: Color(0xFD040842),
                            suffix: showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            isPassword: showPassword,
                            suffixPressed: () {
                              // log('$showPassword');
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Password musn\'t be empty';
                              }
                              return null;
                            },
                            prefixIconColor: Color(0xFD040842),
                            // hintStyleColor: Colors.black26,
                            // backgroundHintColor: Color(0xFCF8D2E7),
                            labelText: 'Password',
                            labilStyleColor: Color(0xFD040842),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultLoginFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            hintText: 'Email Address',
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email address';
                              }
                            },
                            prefix: Icons.phone_android_outlined,
                            // backgroundHintColor: Colors.white,
                            prefixIconColor: Color(0xFD040842),
                            // hintStyleColor: Colors.black26,
                            labelText: 'Phone',
                            labilStyleColor: Color(0xFD040842),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultLoginButton(
                            width: double.infinity,
                            //backround: Colors.blue,
                            function: () {
                              // validateAndSubmit(context);

                            },
                            text: 'SignUp',
                            radius: 8.0,
                            backround: Color(0xFD040842),
                            textButtonColor: Colors.white,
                            fontSize: 17.0,
                          ),
                          SizedBox(height: 12.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Back to Login',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(Icons.arrow_forward),
                              SizedBox(
                                width: 3.0,
                              ),
                              defaultTextButton(
                                function: () {
                                  navigators.navigateTo(context, LoginScreen());
                                },
                                text: 'Login',
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
}
