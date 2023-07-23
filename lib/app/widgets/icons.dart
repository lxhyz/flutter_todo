import 'package:flutter/material.dart';
import 'package:get_todo_list/app/core/values/colors.dart';
import 'package:get_todo_list/app/core/values/icons.dart';

List<Icon> getIcons() {
  return [
    Icon(IconData(personIcon,fontFamily: 'MaterialIcons'),color: purple,),
    Icon(IconData(workIcon,fontFamily: 'MaterialIcons'),color: pink,),
    Icon(IconData(moviceIcon,fontFamily: 'MaterialIcons'),color: deepPink,),
    Icon(IconData(sportIcon,fontFamily: 'MaterialIcons'),color: green,),
    Icon(IconData(tracelIcon,fontFamily: 'MaterialIcons'),color: yellow,),
    Icon(IconData(shopIcon,fontFamily: 'MaterialIcons'),color: blue,),
  ];
}