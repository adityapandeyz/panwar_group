import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:panwar_group/firebase_options.dart';
import 'package:provider/provider.dart';

import 'pages/front_page.dart';
import 'pages/login_page.dart';
import 'provider/auth_provider.dart';
import 'provider/current_department_provider.dart';
import 'provider/current_firm_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AdminAuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CurrentFirmProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CurrentDepartmentProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            toolbarHeight: 45,
            elevation: 6,
            // color: Color.fromARGB(255, 30, 45, 59),
            titleTextStyle: TextStyle(
              fontSize: 14,
              // color: Colors.white,
            ),
          ),
          // colorScheme: ColorScheme.fromSwatch().copyWith(
          //   primary: const Color.fromARGB(255, 55, 132, 204),
          //   secondary: const Color.fromARGB(255, 55, 132, 204).withOpacity(0.8),
          //   tertiary: const Color.fromARGB(255, 55, 132, 204).withOpacity(0.60),
          // ),
        ),
        home: const FrontPage(),
      ),
    );
  }
}

// class NextScreen extends StatelessWidget {
//   const NextScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           return const Center(
//             child: Text('Something went wrong!'),
//           );
//         } else if (snapshot.hasData) {
//           return const HomePage();
//         } else {
//           return const LoginPage();
//         }
//       },
//     );
//   }
// }
