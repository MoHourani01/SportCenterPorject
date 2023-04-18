import 'package:shared_preferences/shared_preferences.dart';

class VariablesUtils {
  static late SharedPreferences prefs;
  static String uid = '';
  static String userName = '';
  static String email = '';
  static String password = '';
  static String rePassword = '';
  static String phone = '';
  static String imageUrl = '';
  static String userType = '';
  static bool loginState = false;
  static bool state = false;
  static bool onBoardingShow = true;


  static double customerPercent = 0;
  static double vendorCustomer = 0;


  static List<String> totalPrice = [];

}

VariablesUtils vUtils = VariablesUtils();

class ProductsUtils {
  static late SharedPreferences prefs;
  static String productId = '';
  static String name = '';
  static String price = '';
  static String image = '';
  static String description = '';



  static double customerPercent = 0;


  static List<String> totalPrice = [];

}
ProductsUtils pUtils = ProductsUtils();