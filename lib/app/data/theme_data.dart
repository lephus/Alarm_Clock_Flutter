import 'package:flutter/material.dart';

class CustomColors {
  static Color primaryTextColor = Colors.white;
  static Color dividerColor = Colors.white54;
  static Color pageBackgroundColor = Color(0xFF2D2F41);
  static Color menuBackgroundColor = Color(0xFF242634);
  static Color blackColor = Colors.black;

  static Color clockBG = Color(0xFF444974);
  static Color clockOutline = Color(0xFFEAECFF);
  static Color secHandColor = Colors.orange[300];
  static Color minHandStatColor = Color(0xFF748EF6);
  static Color minHandEndColor = Color(0xFF77DDFF);
  static Color hourHandStatColor = Color(0xFFC279FB);
  static Color hourHandEndColor = Color(0xFFEA74AB);
  static Color runTimerInside = Color(0xFF61A3FE);
  static Color runTimerOutside = Color(0xFFC279FB);
}

class GradientColors{
  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];

  List<Color> GetGradientColors(int index){
    if(index == 0){
      return sky;
    }
    if(index == 1){
      return sunset;
    }
    if(index == 2){
      return sea;
    }
    if(index == 3){
      return mango;
    }
    if(index == 4){
      return fire;
    }
  }

}