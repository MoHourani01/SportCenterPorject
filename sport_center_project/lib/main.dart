import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_center_project/Screens/MainNavBar/main_navigation_bar.dart';
import 'package:sport_center_project/Screens/basketball/basketball_layout/basketball_screen.dart';
import 'package:sport_center_project/Screens/basketball/basketball_products/basketball_product_details/basketball_details.dart';
import 'package:sport_center_project/Screens/home/home_screen.dart';
import 'package:sport_center_project/Screens/product_component/product_service/product_service.dart';
import 'package:sport_center_project/Screens/profile/Profile_Screen.dart';
import 'package:sport_center_project/cubit/cubit.dart';
import 'package:sport_center_project/models/product_model.dart';
import 'package:sport_center_project/registration/login/login_cubit/login_cubit.dart';
import 'package:sport_center_project/registration/login/login_cubit/login_states.dart';
import 'package:sport_center_project/registration/login/login_screen.dart';
import 'package:sport_center_project/shared/network/shared.network.remote/dio_helper.dart';
import 'package:sport_center_project/soccer/soccer_layout/soccer_screen.dart';
import 'package:sport_center_project/soccer/soccer_products/soccer_product_details/soccer_details.dart';
import 'package:sport_center_project/splash/Splash_Screen.dart';

import 'Screens/onBoarding_Screen/onBoarding.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DioHelper.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setBool('productsAddedToFirebase', false);
  ProductService.addProducts(ProductsModel.products);
  ProductsModel().addProductIds(products);
  print(products);
  runApp(MyApp());
}
List<ProductsModel> products=[
  ProductsModel(
    name: 'Man United Jersey',
    price: '50 JD',
    image: 'https://cdn.shopify.com/s/files/1/0002/6440/5057/products/Home1OG.jpg',
  ),
  ProductsModel(
    name: 'Barcelona Jersey',
    price: '50 JD',
    image: 'https://arenajerseys.com/wp-content/uploads/2022/06/download-4.jpg',
  ),
  ProductsModel(
    name: 'RealMadrid Jersey',
    price: '50 JD',
    image: 'https://cdn.shopify.com/s/files/1/0405/9807/7603/products/HF0291-RMCFMZ0074-02_500x480.jpg?v=1655974763',
  ),
  ProductsModel(
    name: 'Miami Heat Jersey',
    price: '60 JD',
    image: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/fddec8b1-7aee-4b47-826d-f2ec00ad4e66/miami-heat-association-edition-2022-23-dri-fit-nba-swingman-jersey-gLpkQ8.png',
  ),
];
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
        // BlocProvider(create: (BuildContext context) => SportCenterCubit(),
        // ),
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
            //home: SplashScreen(title:'login'),
            home: ProfileScreen(),
            // home:SplashScreen(title: 'onBoarding'),
              // home:MainNavigationBar(),
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


