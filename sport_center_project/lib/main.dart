import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_center_project/Screens/MainNavBar/main_navigation_bar.dart';
import 'package:sport_center_project/Screens/home/home_screen.dart';
import 'package:sport_center_project/Screens/soccer/home.dart';
import 'package:sport_center_project/registration/login/login_cubit/login_cubit.dart';
import 'package:sport_center_project/registration/login/login_cubit/login_states.dart';
import 'package:sport_center_project/registration/login/login_screen.dart';
import 'package:sport_center_project/shared/network/shared.network.remote/dio_helper.dart';
import 'package:sport_center_project/splash/Splash_Screen.dart';

import 'Screens/onBoarding_Screen/onBoarding.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context)  => LoginCubit(),
        ),
      ],
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            theme: ThemeData(
              // primaryColor: _primaryColor,
              // accentColor: _accentColor,
              // useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            // title: 'Flutter',
            // home: SplashScreen(title:'login'),
            home:Home(),
          );
        },
      ),
    );
  }
}

// ############################################
// import 'package:flutter/material.dart';
//
// import 'package:sport_center_project/Screens/news/api_manager.dart';
//
// import 'package:sport_center_project/Screens/news/pagebody.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SoccerApp(),
//     );
//   }
// }
//
// class SoccerApp extends StatefulWidget {
//   @override
//   _SoccerAppState createState() => _SoccerAppState();
// }
//
// class _SoccerAppState extends State<SoccerApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFAFAFA),
//       appBar: AppBar(
//         backgroundColor: Color(0xFFFAFAFA),
//         elevation: 0.0,
//         title: Text(
//           "SOCCERBOARD",
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       //now we have finished the api service let's call it
//       //Now befo re we create Our layout let's create our API service
//       body: FutureBuilder(
//         future: SoccerApi()
//             .getAllMatches(), //Here we will call our getData() method,
//         builder: (context, snapshot) {
//           //the future builder is very intersting to use when you work with api
//           if (snapshot.hasData) {
//             print((snapshot.data)!.length);
//             return PageBody(snapshot.data!);
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         }, // here we will buil the app layout
//       ),
//     );
//   }
// }
//So as we can see w got our matches data,
// the data size depend on the date and the time so
// you can get as many data as many matches are curetly playing
//Now let's try to get data by seasons and leagues


