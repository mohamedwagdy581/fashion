import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/product_details.dart';
//import 'package:fluttertoast/fluttertoast.dart';

// Reusable Navigate Function and return to the previous screen
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

// Reusable Navigate Function and remove the previous screen
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

// Reusable TextFormField Function with validator
Widget defaultTextFormField({
  required TextEditingController? controller,
  required TextInputType keyboardType,
  required String? label,
  TextStyle? textStyle,
  VoidCallback? onTap,
  required String? Function(String?)? validator,
  Function(String)? onSubmitted,
  bool secure = false,
  IconData? prefix,
  Color? prefixColor,
  IconData? suffix,
  Color? suffixColor,
  VoidCallback? suffixPressed,
  bool? isClickable,
}) =>
    Container(
      //color: Colors.white,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white60,
      ),
      child: TextFormField(
        style: textStyle,
        controller: controller,
        keyboardType: keyboardType,
        onTap: onTap,
        enabled: isClickable,
        validator: validator,
        obscureText: secure,
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.blueAccent,fontSize: 16.0),
            prefixIcon: Icon(
              prefix,
              color: prefixColor,
            ),
            suffixIcon: IconButton(
              icon: Icon(suffix),
              onPressed: suffixPressed,
              color: suffixColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
      ),
    );

Widget customListTileWidget({
  required VoidCallback onTapped,
  required Widget title,
  Widget? subTitle,
  Widget? leadingWidget,
  Widget? trailingWidget,
}) {
  return ListTile(
    onTap: onTapped,
    title: title,
    subtitle: subTitle,
    leading: leadingWidget,
    trailing: trailingWidget,
  );
}

Widget defaultSigningInRowButton({
  required String title,
  TextStyle? titleStyle,
  required double width,
  required IconData icon,
  Color iconColor = Colors.black,
  Color rowBackgroundColor = Colors.white,
  required VoidCallback onPressed,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: rowBackgroundColor,
        onPressed: onPressed,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            SizedBox(
              width: width,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: titleStyle,
              ),
            ),
          ],
        ),
      ),
    );

Widget customButton({
  required VoidCallback onPressed,
  required String text,
  Color? backgroundColor,
}) =>
    Container(
      //height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0),),),
        ),
        child: Text(
          text,
        ),
      ),
    );

Widget defaultButton({
  required VoidCallback onPressed,
  required String text,
  Color? backgroundColor,
}) =>
    Container(
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: MaterialButton(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required VoidCallback onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

void showToast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 6,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0,
    );

Widget singleProduct({
  required context,
  required prodId,
  required prodName,
  required prodPicture,
  required prodPrice,
  required prodOldPrice,
  required prodDetails,
  required prodBrand,
  required prodColor,
  required prodSize,
}) =>
    Card(
      child: Hero(
          tag: Text(prodName),
          child: Material(
            child: InkWell(
              onTap: () {
                navigateTo(
                  context,
                  ProductDetailsScreen(
                    productDetailsId: prodId,
                    productDetailsName: prodName,
                    productDetailsPicture: prodPicture,
                    productDetailsPrice: prodPrice,
                    productDetailsOldPrice: prodOldPrice,
                    productDetails: prodDetails,
                    productDetailsBrand: prodBrand,
                    productDetailsColor: prodColor,
                    productDetailsSize: prodSize,
                  ),
                );
              },
              child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 1.0,
                      bottom: 1.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            prodName,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Text(
                          '$prodPrice \$',
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                child: Image.network(
                  prodPicture,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          )),
    );

// ignore: constant_identifier_names
enum ToastStates { SUCCESS, ERROR, WARNING }

Color? chooseToastColor(ToastStates state) {
  Color? color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget customListTile({
  required VoidCallback onTapped,
  required String title,
  Widget? leadingWidget,
  Widget? trailingWidget,
}) {
  return InkWell(
    onTap: onTapped,
    child: ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
      leading: leadingWidget,
      trailing: trailingWidget,
    ),
  );
}
