import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:yatek_interview/login/login_provider/login_state.dart';
import 'package:yatek_interview/profile_screen/profile_screen.dart';

import 'login_provider/login_provider.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loginSTate = ref.watch(loginProvider);
    ref.listen<LoginState>(loginProvider, (prev, next) {
      next.maybeWhen(
          orElse: () {},
          success: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ProfileScreen()));
          },
          error: (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(e),
            ));
          });
    });

    var formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 200,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.email(),
                FormBuilderValidators.required(),
              ]),
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
              decoration: InputDecoration(
                labelText: 'Password',
                
              ),
            ),
            const SizedBox(height: 20),
            Builder(builder: (context) {
              return loginSTate.maybeWhen(loading: () {
                return CircularProgressIndicator();
              }, orElse: () {
                return MaterialButton(
                  child:const Text('Login'),
                  color: Colors.blue,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ref.read(loginProvider.notifier).login(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                    }
                  },
                );
              });
            }),
          ],
        ),
      ),
    );
  }
}
