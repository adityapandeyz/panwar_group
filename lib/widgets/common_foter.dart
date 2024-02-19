import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonFooter extends StatelessWidget {
  const CommonFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Image.asset(
              'assets/images/2.jpg',
              height: 400.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Container(
            width: double.maxFinite,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Center(
                child: Row(
                  children: [
                    //const Spacer(),
                    const SizedBox(
                      width: 20,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         height: 50,
                    //         width: 50,
                    //         margin: const EdgeInsets.all(6.0),
                    //         decoration: const BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           color: Color.fromARGB(255, 255, 238, 0),
                    //         ),
                    //         child: const Icon(
                    //           FontAwesomeIcons.truck,
                    //           color: Color.fromARGB(255, 0, 0, 0),
                    //           size: 30,
                    //         ),
                    //       ),
                    //       const Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 30),
                    //         child: VerticalDivider(
                    //           color: Color.fromARGB(255, 156, 156, 156),
                    //           thickness: 1,
                    //         ),
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             'FREE SHIPPING',
                    //             style: GoogleFonts.poppins(
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.black,
                    //             ),
                    //           ),
                    //           Text(
                    //             'On Orders Above ₹499',
                    //             style: GoogleFonts.poppins(
                    //               fontSize: 14,
                    //               color: Colors.black,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const Spacer(),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.all(6.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 255, 238, 0),
                          ),
                          child: const Icon(
                            FontAwesomeIcons.undo,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 30,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: VerticalDivider(
                            color: Color.fromARGB(255, 156, 156, 156),
                            thickness: 1,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'EASY RETURNS',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '15-Day Return Policy',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // const Spacer(),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.all(6.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 255, 238, 0),
                          ),
                          child: const Icon(
                            FontAwesomeIcons.percentage,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 30,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: VerticalDivider(
                            color: Color.fromARGB(255, 156, 156, 156),
                            thickness: 1,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '100% AUTHENTIC',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Products Sourced Directly',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    // const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 100,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 204, 203, 203),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Cc_by-nc-nd_icon.svg/88px-Cc_by-nc-nd_icon.svg.png',
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Attribution-NonCommercial-NoDerivatives | Panwar Group | Github.com/adityapandeyz',
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
