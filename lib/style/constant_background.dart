import 'package:flutter/material.dart';
import 'package:testcaninno/style/constant_color.dart';

class Constant_Background {
  BoxDecoration background() =>  BoxDecoration(
          gradient: LinearGradient(colors: [
        Constant_Color().green,
       Constant_Color().greendark
      ],   begin: Alignment.topCenter,
          end: Alignment.bottomCenter),);
}