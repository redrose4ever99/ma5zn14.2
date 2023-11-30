import 'package:sizer/sizer.dart';

double height(double newHeight) {
  double finalHeight = (newHeight * 100) / 812;
  return finalHeight.h;
}

double width(double newWidth) {
  double finalWidth = (newWidth * 100) / 375;
  return finalWidth.w;
}
