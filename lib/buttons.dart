// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Keywidget extends StatelessWidget {
  const Keywidget({
    Key? key,
    required this.text,
    required this.color,
    required this.BackgroundColor,
    required this.Pressed,
  }) : super(key: key);

  final String text;
  final Color color;
  final Color BackgroundColor;
  final Pressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Pressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 85,
          width: 85,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
              color: BackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text,
                  style: GoogleFonts.unbounded(
                    fontSize: 60,
                    fontWeight: FontWeight.w400,
                    color: color,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
