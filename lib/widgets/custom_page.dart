import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/front_page.dart';
import '../provider/auth_provider.dart';

class CustomPage extends StatelessWidget {
  final Widget widget;
  final bool isShowLogout;
  const CustomPage({
    super.key,
    required this.widget,
    this.isShowLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminAuthProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('HR Management System'),
          actions: [
            isShowLogout == false
                ? ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const FrontPage(),
                      ),
                    ),
                    child: const Text('Back'),
                  )
                : ElevatedButton(
                    onPressed: () {
                      provider.logoutAdmin(context);
                    },
                    child: const Text('Logout'),
                  ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Stack(
          children: [
            ClipRRect(
              child: Image.network(
                'https://images.unsplash.com/photo-1705077044082-bebb7f597cee?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height < 800
                          ? MediaQuery.of(context).size.height * 0.8
                          : 600,
                      width: MediaQuery.of(context).size.width > 800
                          ? MediaQuery.of(context).size.width * 0.4
                          : 600,
                      child: widget,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
