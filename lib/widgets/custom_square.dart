import 'package:flutter/material.dart';

class CustomSquare extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback ontap;
  const CustomSquare(
      {super.key,
      required this.icon,
      required this.title,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: InkWell(
        onTap: ontap,
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 60,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
