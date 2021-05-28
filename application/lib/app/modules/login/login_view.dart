import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../constants/style_constants.dart';
import '../../routes/app_pages.dart';
import '../../shared/button.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double width = Get.width;
    final double height = Get.height;
    String? _email;
    String? _password;
    final RxBool _showPassword = false.obs;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: GetPlatform.isWeb ? width * .18 : width * .05,
          vertical: height * 0.07,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: SizedBox(
                        height: height * .3,
                        child: Image.asset('assets/icons/icon.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter an email-address';
                        }
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
                            onPressed: () => _showPassword.toggle(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  controller.obx(
                    (state) {
                      Future.delayed(
                        Duration.zero,
                        () => Get.offAllNamed(Routes.MAP),
                      );
                      return const SizedBox.shrink();
                    },
                    onLoading: const Center(child: CircularProgressIndicator()),
                    onError: (error) => Text(error!),
                    onEmpty: const Text('Press the button 👇'),
                  ),
                  Button(
                    isTextOnly: false,
                    text: 'Log In',
                    icon: Icons.lock_open,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        controller.login(
                          email: _email!,
                          password: _password!,
                        );
                      }
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
        ),
      ),
    );
  }
}
