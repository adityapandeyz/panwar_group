import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parallax_animation/parallax_animation.dart';

import '../widgets/common_foter.dart';
import '../widgets/group_logo_widget.dart';
import 'login_page.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 65,
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CircleAvatar(
            //   radius: 20,
            //   backgroundImage: AssetImage(
            //     'assets/logo/zeal_fashion_logo.jpg',
            //   ),
            // ),
            // SizedBox(
            //   width: 10,
            // ),
            GroupLogoWidget()
          ],
        ),
        actions: [
          // IconButton(
          //   onPressed: () {

          //   },
          //   icon: const Icon(
          //     FontAwesomeIcons.search,
          //   ),
          // ),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const LoginPage(),
              ),
            ),
            child: const Text('Login'),
          ),
          // const SizedBox(
          //   width: 20,
          // ),
          // ExpandableSearchBar(
          //   iconSize: 45,
          //   backgroundColor: const Color.fromARGB(255, 224, 223, 223),
          //   iconColor: const Color.fromARGB(255, 231, 230, 230),
          //   onTap: () {},
          //   hintText: 'Search',
          //   editTextController: searchController,
          // ),
          const SizedBox(
            width: 10,
          ),
          // TextButton(
          //   onPressed: () {},
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       const Icon(
          //         FontAwesomeIcons.location,
          //         color: Colors.black,
          //       ),
          //       const SizedBox(
          //         height: 5,
          //       ),
          //       1000 < MediaQuery.of(context).size.width
          //           ? const Text(
          //               "TRACK ORDER",
          //               style: TextStyle(
          //                 fontSize: 12,
          //                 color: Colors.black,
          //               ),
          //             )
          //           : Container(),
          //     ],
          //   ),
          // ),
          const SizedBox(
            width: 10,
          ),
          // TextButton(
          //   onPressed: () {},
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       const Icon(
          //         FontAwesomeIcons.cartShopping,
          //         color: Colors.black,
          //       ),
          //       const SizedBox(
          //         height: 5,
          //       ),
          //       1000 < MediaQuery.of(context).size.width
          //           ? const Text(
          //               "CART",
          //               style: TextStyle(
          //                 fontSize: 12,
          //                 color: Colors.black,
          //               ),
          //             )
          //           : Container(),
          //     ],
          //   ),
          // ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      drawer: Drawer(
        width: 500,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: const EdgeInsets.only(left: 20, right: 20),
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Firms',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                ClipRRect(
                  child: Image.network(
                    'https://adn-static1.nykaa.com/nykdesignstudio-images/pub/media/wysiwyg/mm_images/shop/shop_women.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Zeal Fashion',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Shop Westernwar, Indianwear and More',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                ClipRRect(
                  child: Image.network(
                    'https://adn-static1.nykaa.com/nykdesignstudio-images/pub/media/wysiwyg/mm_images/shop/shop_men.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Panwar Texcone',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Shop Formals, Casuals and Denims',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                ClipRRect(
                  child: Image.network(
                    'https://adn-static1.nykaa.com/nykdesignstudio-images/pub/media/wysiwyg/mm_images/shop/shop_kids.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Panwar Handloom',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Shop for Boys, Girls and Infants',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            const Center(child: GroupLogoWidget()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Zeal Fashion | Panwar Texcone | Panwar Handloom ',
                  style: GoogleFonts.poppins(),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            // Stack(
            //   alignment: Alignment.centerLeft,
            //   children: [
            //     ClipRRect(
            //       child: Image.network(
            //         'https://adn-static1.nykaa.com/nykdesignstudio-images/pub/media/wysiwyg/mm_images/shop/shop_brands.jpg',
            //         height: 200,
            //         width: double.infinity,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(12.0),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             'All Brands',
            //             style: GoogleFonts.poppins(
            //               fontSize: 16,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           // Text(
            //           //   'Explore our curated selection of brands',
            //           //   style: GoogleFonts.poppins(
            //           //     fontSize: 12,
            //           //   ),
            //           // ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(
                'https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                height: 800,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1603782637810-95d06f1d5663?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    height: 800,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Text(
                      "Completely Made In India Fabric",
                      style: GoogleFonts.lobsterTwo(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1566596825056-e80d32d481d8?q=80&w=2073&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    height: 800,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Text(
                      'Driven By Legacy',
                      style: GoogleFonts.lobsterTwo(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1476683874822-744764a2438f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    height: 800,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Text(
                      'Highest Standard In Garments',
                      style: GoogleFonts.lobsterTwo(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Text(
                  'Our Supliers',
                  style: GoogleFonts.alata(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                  softWrap: true,
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  const Spacer(),
                  ClipRRect(
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTp9_lrEH25AmL4Uh4G6d5bOqu-J7aAVAZf95_3fsx7SSnqjBA2VtdTrys1ZD5FiehwAk&usqp=CAU',
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  ClipRRect(
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a1/Raymond_logo.svg/1024px-Raymond_logo.svg.png',
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  ClipRRect(
                    child: Image.network(
                      'https://images.squarespace-cdn.com/content/v1/6206a24e38ca4200c0141c78/eb981460-27c1-4915-8dc3-ff0cc396f109/BSL+Logo-02.png?format=1500w',
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Text(
                  'Our Firms',
                  style: GoogleFonts.alata(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                  softWrap: true,
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  const Spacer(),
                  ClipRRect(
                    child: Image.asset(
                      'assets/logo/ptx_logo.png',
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  ClipRRect(
                    child: Image.asset(
                      'assets/logo/zeal_fashion_logo.jpg',
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // const SizedBox(
                  //   width: 60,
                  // ),
                  // ClipRRect(
                  //   child: Image.network(
                  //     'https://images.squarespace-cdn.com/content/v1/6206a24e38ca4200c0141c78/eb981460-27c1-4915-8dc3-ff0cc396f109/BSL+Logo-02.png?format=1500w',
                  //     height: 100,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const CommonFooter(),
          ],
        ),
      ),
    );
  }
}
