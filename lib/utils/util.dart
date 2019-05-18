import 'package:flutter/material.dart';

calculateHeight(BuildContext context, double heigth) {
  return MediaQuery.of(context).size.height * heigth;
}

calculateWidth(BuildContext context, double width) {
  return MediaQuery.of(context).size.width * width;
}