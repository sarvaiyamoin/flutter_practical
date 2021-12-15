import 'package:flutter/material.dart';
import 'package:flutter_practical/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.put(AuthController());
  final _form = GlobalKey<FormState>();
  String _userName = "";
  String _userEmail = "";
  String _userPassword = "";
  var _isLogin = true;
  Future<void> _submit() async {
    final _isValid = _form.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      _form.currentState!.save();
      try {
        await authController.submit(_userName.trim(), _userEmail.trim(),
            _userPassword.trim(), _isLogin);
      } catch (error) {
        Get.rawSnackbar(title: 'Error', message: '$error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    // print("width : ${Get.width}");
    // // ignore: avoid_print
    // print("height : ${Get.height}");
    return Scaffold(
      body: Obx(() {
        return authController.isLoading.value
            ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(),
                    Text("  Loading...."),
                  ],
                ),
              )
            : Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: Get.height * 0.40,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(100)),
                          gradient: LinearGradient(
                              colors: [Colors.purple, Color(0xffcc3399)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: const FractionalOffset(0.9 / 2, 0.3),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const FaIcon(FontAwesomeIcons.userAlt,
                                      size: 70, color: Colors.white)),
                            ),
                            Positioned(
                              bottom: 30,
                              right: 30,
                              child: Text(
                                _isLogin ? "Login" : "Sign Up",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: context.isSmallTablet
                            ? Get.width * 0.50
                            : Get.width * 0.85,
                        child: Column(
                          children: [
                            if (!_isLogin)
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, right: 20, left: 20),
                                  child: TextFormField(
                                    key: ValueKey('name'),
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.purple)),
                                      hintText: 'User name',
                                      icon: FaIcon(FontAwesomeIcons.userCircle),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 6) {
                                        return "User Name must be 6 character logn";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _userName = value!;
                                    },
                                  ),
                                ),
                              ),
                            const SizedBox(
                              height: 15,
                            ),
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, right: 20, left: 20),
                                child: TextFormField(
                                  key: ValueKey('email'),
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple)),
                                    hintText: 'Email',
                                    icon: Icon(Icons.email),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter correct email";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _userEmail = value!;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, right: 20, left: 20),
                                child: TextFormField(
                                  key: ValueKey('password'),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 8) {
                                      return "Password must be  8 character long";
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple)),
                                    hintText: 'Password',
                                    icon: FaIcon(FontAwesomeIcons.key),
                                  ),
                                  onSaved: (value) {
                                    _userPassword = value!;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        _isLogin
                                            ? "Don't have an account?"
                                            : "Already have an account?",
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                    });
                                  },
                                  child: Text(
                                    _isLogin ? "Sign Up" : "Login",
                                    style:
                                        TextStyle(color: Colors.purpleAccent),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(0.0)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80)))),
                                onPressed: () {
                                  _submit();
                                },
                                child: Ink(
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colors.purple,
                                          Color(0xffcc3399)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                        maxWidth: double.infinity,
                                        minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      _isLogin ? "LOGIN" : "SIGN UP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
