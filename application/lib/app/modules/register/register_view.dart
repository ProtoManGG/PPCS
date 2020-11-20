import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts.dart';
import '../../routes/app_pages.dart';
import '../../shared/button.dart';
import 'register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String _email;
    String _password;
    String _fullName;
    String _phoneNum;
    final RxBool _showPassword = false.obs;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('RegisterView'),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * .05,
          vertical: Get.height * 0.07,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: Get.height * .3,
                    child: Image.asset('assets/icons/icon.png'),
                  ),
                ),
                SizedBox(
                  height: Get.height * .05,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (!GetUtils.isAlphabetOnly(value) ||
                                  value.length > 20) {
                                return 'Not a valid First Name';
                              }
                              _fullName = value;
                              return null;
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            decoration: style.kInputDecoration.copyWith(
                                hintText: '', labelText: 'First Name')),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (!GetUtils.isAlphabetOnly(value) ||
                                  value.length > 20) {
                                return 'Not a valid Last Name';
                              }
                              _fullName += " $value";
                              return null;
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            decoration: style.kInputDecoration.copyWith(
                                hintText: '', labelText: 'Last Name')),
                      ),
                    ],
                  ),
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
                      textInputAction: TextInputAction.next,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (!GetUtils.isLengthEqualTo(value, 10)) {
                        return 'Please enter a valid Phone Number';
                      }
                      _phoneNum = value;
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                    decoration: style.kInputDecoration.copyWith(
                      hintText: 'Enter your Phone Number',
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.state.value == RegisterState.initial) {
                    return const Text('Press the button 👇');
                  } else if (controller.state.value == RegisterState.loading) {
                    return const CircularProgressIndicator();
                  } else if (controller.state.value == RegisterState.loaded) {
                    if (controller.failure != null) {
                      return Text(controller.failure);
                    } else {
                      Future.delayed(
                        Duration.zero,
                        () {
                          Get.offAllNamed(Routes.MAP);
                        },
                      );
                      return Text(controller.data);
                    }
                  } else {
                    return Text(controller.data);
                  }
                }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Button(
                    isTextOnly: false,
                    text: 'Register',
                    icon: Icons.vpn_key,
                    onPressed: () async {
                      if (controller.state.value == RegisterState.initial ||
                          controller.state.value == RegisterState.loaded) {
                        if (_formKey.currentState.validate()) {
                          try {
                            controller.postService(
                              phoneNum: _phoneNum,
                              email: _email,
                              password: _password,
                              fullName: _fullName,
                            );
                          } catch (e) {
                            if (!Get.isSnackbarOpen) {
                              Get.snackbar("Error", e.toString());
                            }
                          }
                        }
                      } else {}
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
