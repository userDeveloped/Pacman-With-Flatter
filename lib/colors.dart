import 'package:flutter/material.dart';

StringToColor(String color)
{
  color = color.toUpperCase().replaceAll("#", "");
  if(color.length == 6)
    {
      color = "FF"+color;
    }
  return Color(int.parse(color, radix: 16));
}