import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomKarlaText extends StatelessWidget {
  const CustomKarlaText(
      {super.key,
      required this.text,
      this.size,
      this.weight,
      this.color,
      this.align,
      this.overflow});
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? TextAlign.center,
      overflow: overflow ?? TextOverflow.clip,
      style: GoogleFonts.karla(
          fontSize: size?.sp ?? 12.sp,
          fontWeight: weight ?? FontWeight.normal,
          color: color ?? Colors.black),
    );
  }
}
