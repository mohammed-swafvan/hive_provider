import 'package:flutter/material.dart';

const kHeight10 = SizedBox(height: 10);
const kHeight20 = SizedBox(height: 20);

//colors
const kBlackColor = Colors.black;
const kWhiteColor = Colors.white;
final kBlackColorOpacity5 = Colors.black.withOpacity(0.5);
final kWhiteColorOpacity5 = Colors.white.withOpacity(0.5);
final kWhiteColorOpacity8 = Colors.white.withOpacity(0.8);

//text style
final kdetailsTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: kWhiteColorOpacity8);
const  kaddStdTextStyle =  TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold);

// input decoration for adding student text form field
kInputDecoration({required String hintText, required String labelText}) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: kWhiteColor.withOpacity(0.6),
        width: 2.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: kWhiteColor.withOpacity(0.6),
        width: 2.0,
      ),
    ),
    labelStyle: TextStyle(color: kWhiteColorOpacity5),
    hintStyle: TextStyle(color: kWhiteColorOpacity5),
    hintText: hintText,
    labelText: labelText,
  );
}

var kelevatedButtonStyle = ButtonStyle(backgroundColor: MaterialStatePropertyAll(kWhiteColorOpacity5));
