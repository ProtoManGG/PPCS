import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecosystem_trial/app/data/providers/api_client.dart';
import 'package:getx_ecosystem_trial/app/data/repository/repository.dart';
import 'package:getx_ecosystem_trial/app/shared/location_data_sender.dart';
import 'package:location/location.dart';

import '../../constants/constants.dart';
import '../../constants/style_constants.dart';
import '../../routes/app_pages.dart';
import '../../shared/button.dart';
import '../map/map_controller.dart';
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
                  if (controller.currentState.value == AppState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.currentState.value == AppState.loaded) {
                    Future.delayed(
                      Duration.zero,
                      () {
                        Get.offAllNamed(Routes.MAP);
                      },
                    );
                    return const SizedBox.shrink();
                  } else {
                    return Text(controller.data);
                  }
                }),
                Button(
                  isTextOnly: false,
                  text: 'Sign Up',
                  icon: Icons.lock_open,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      final LocationData locationData =
                          await sendLocationData();
                      controller.signUp(
                        username: _fullName,
                        phonenum: int.parse(_phoneNum),
                        email: _email,
                        password: _password,
                        longitude: locationData.longitude,
                        latitude: locationData.latitude,
                      );
                    } else {}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
