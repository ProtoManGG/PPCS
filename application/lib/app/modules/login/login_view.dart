import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecosystem_trial/app/constants/constants.dart';
import 'package:getx_ecosystem_trial/app/constants/style_constants.dart';

import '../../routes/app_pages.dart';
import '../../shared/button.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String _email;
    String _password;
    final RxBool _showPassword = false.obs;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('LoginView'),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * .05,
          vertical: Get.height * 0.07,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: Get.height * .3,
                    child: Image.asset('assets/icons/icon.png'),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * .05,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email-address';
                    }
                    _email = value;
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                  decoration: style.kInputDecoration,
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.send,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (!GetUtils.isLengthBetween(value, 8, 12)) {
                        return 'Please enter a valid password';
                      }
                      _password = value;
                      return null;
                    },
                    obscureText: !_showPassword.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                    decoration: style.kInputDecoration.copyWith(
                      hintText: 'Enter your Password',
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: _showPassword.value
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          _showPassword.value = !_showPassword.value;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() {
                if (controller.currentState.value == AppState.initial) {
                  return const Text('Press the button 👇');
                } else if (controller.currentState.value == AppState.loading) {
                  return const CircularProgressIndicator();
                } else if (controller.currentState.value == AppState.loaded) {
                  Future.delayed(
                    Duration.zero,
                    () {
                      Get.offAllNamed(Routes.MAP);
                    },
                  );
                  return Text(controller.data);
                } else {
                  return Text(controller.data);
                }
              }),
              Button(
                isTextOnly: false,
                text: 'Log In',
                icon: Icons.lock_open,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    controller.login(email: _email, password: _password);
                  } else {}
                },
              ),
              Button(
                isTextOnly: false,
                text: 'Sign Up',
                icon: Icons.vpn_key,
                onPressed: () => Get.toNamed(Routes.REGISTER),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
