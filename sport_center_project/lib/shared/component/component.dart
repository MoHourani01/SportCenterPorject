import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultLoginFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(dynamic)? onSubmit,
  Function(dynamic)? onChanged,
  //Function? onTap,
  String? hintText,
  required String labelText,
  required Function validate,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  void Function()? suffixPressed,
  Function()? onTap,
  Color? hintStyleColor,
  Color? labilStyleColor,
  Color? BorderColor,
  Color? prefixIconColor,
  Color? suffixIconColor,
  Color? backgroundHintColor,
}) =>
    Center(
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        onFieldSubmitted: (onSubmit) {},
        onChanged: (String onChanged) {},
        obscureText: isPassword,
        cursorColor: Color(0xFD040842),
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(color: labilStyleColor),
          hintStyle: TextStyle(color: hintStyleColor),
          prefixIcon: Icon(
            prefix,
            color: prefixIconColor,
          ),
          suffixIcon: suffix != null
              ? IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffix,
              color: suffixIconColor,
            ),
          )
              : null,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color:Colors.blueGrey.shade900.withOpacity(1),
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.blueGrey.shade900.withOpacity(1),
              )
          ),
          // border: InputBorder.none
        ),
        validator: (value){
          return validate!(value);
        },

        onTap:onTap!=null?onTap():null,
      ),
    );

Widget defaultLoginButton({
  double width = double.infinity,
  Color backround = Colors.white,
  double radius = 0.0,
  //required Function function,
  //required String text,
  required void Function() function,
  required String text,
  Color textButtonColor = Colors.white,
  double? fontSize,
}) =>
    Container(
      width: width,
      // color: defaultColor,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: textButtonColor,
            fontSize: fontSize,
            // fontFamily: 'Georgia',
            // backgroundColor: defaultColor,
          ),
        ),
      ),
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(blurRadius: 5.0,color: Colors.black26),
        //
        // ],
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: backround,
        // gradient: LinearGradient(
        //   begin: Alignment.bottomLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     Color(0xEC952BE8),
        //     Color(0xECAE67F1),
        //     Color(0xECBB98E1),
        //   ],
        // ),
      ),
    );

Widget defaultTextButton({
  required Function() function,
  required String text,
  Color? textButtonColor,
  double? fontSize,
  Function()? fontWeight,
  String? fontFamily,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: textButtonColor,
          fontSize: fontSize,
          fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
//=======

class Navigators {

  navigateTo(BuildContext context, Widget widget) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => widget), (route) => false);
  }

  navigatorWithBack(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }

  navigatePop(BuildContext context){
    Navigator.pop(context);
  }
}

Navigators navigators = Navigators();

void showToast({required String text,required ToastStates state})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{Success, Error, Warning}

Color? chooseToastColor(ToastStates state){
  Color color;
  switch (state)
  {
    case ToastStates.Success:
      color=Colors.green;
      break;
    case ToastStates.Error:
      color= Colors.red;
      break;
    case ToastStates.Warning:
      color= Colors.amber.shade800;
      break;
  }
  return color;
}

Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey,
  ),
);

Widget buildArticle(article,context) {
  return Padding(
    padding: const EdgeInsets.only(left:8.0, right: 8.0, top: 12.0),
    child: Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade300,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment,
          children: [
            Container(
              width: 150,
              height: 150,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Container(
                  // height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: NetworkImage('${article['urlToImage']}'), fit: BoxFit.cover
                      )
                  ),

                ),
              ),
            ),
            SizedBox(width: 15,),
            // Text('Description',style: TextStyle(fontSize: 20),),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${article['title']}',
                    style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget articleBuilder(list,context,) => ConditionalBuilder(
  // condition: state is! NewsGetBusinessLoadingChange,
  condition: list.length>0,
  builder: (context)=>ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index)=>buildArticle(list[index],context),
      itemCount: 20),
  fallback: (context)=> false ? Container() : Center(child: CircularProgressIndicator()),);
