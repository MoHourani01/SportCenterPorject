import 'package:flutter/material.dart';
import 'package:sport_center_project/registration/register/register_screen.dart';
import 'package:sport_center_project/shared/component/component.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                            'Welcome to Center Jordan',
                            style: TextStyle(color: Colors.black54, fontSize: 17.0),
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
                            suffix: showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            isPassword: showPassword,
                            suffixPressed: () {
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
                              // validateAndSubmit(context);
                              // navigators.navigatePop(context);
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
}
