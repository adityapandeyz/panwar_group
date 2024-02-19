import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_page.dart';
import '../widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return CustomPage(
      widget: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Icon(
              FontAwesomeIcons.userLarge,
              color: Colors.blue,
              size: 140,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextfield(
              label: 'Email',
              controller: emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextfield(
              label: 'Password',
              isPass: true,
              controller: passwordController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              text: 'Authenticate',
              onTap: () {
                Provider.of<AdminAuthProvider>(context, listen: false)
                    .loginUser(
                        emailController.text, passwordController.text, context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Cc_by-nc-nd_icon.svg/88px-Cc_by-nc-nd_icon.svg.png'),
            const Text('Attribution-NonCommercial-NoDerivatives'),
            const Text('- Zeal Fashion -'),
            const Text('Developed by: Github.com/adityapandeyz'),
          ],
        ),
      ),
    );
  }
}
