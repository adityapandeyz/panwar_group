import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupLogoWidget extends StatelessWidget {
  const GroupLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Panwar Group',
      style: GoogleFonts.lobsterTwo(
        textStyle: Theme.of(context).textTheme.displayLarge,
        fontSize: 38,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
