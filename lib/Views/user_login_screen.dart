import 'package:flutter/material.dart';
import 'package:leeyet_machine_test/Controllers/user_controller.dart';
import 'package:leeyet_machine_test/Views/user_register_screen.dart';
import 'package:leeyet_machine_test/Views/user_update_password.dart';
import 'package:provider/provider.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<UserController>(context, listen: false);
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(color: Colors.black),
          ),
          Positioned(
            child: Container(
              width: width,
              height: height / 3.3,
              decoration: const BoxDecoration(color: Colors.black),
              child: const Center(
                child: Text(
                  'OOPACKS',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: height / 1.7,
            width: width,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
              ),
              child: Consumer<UserController>(builder: (context, provider, _) {
                return SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Form(
                      key: provider.loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          const Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: provider.loginEmailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Required Field';
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Email or Phone Number',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Password',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: provider.loginPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Required Field';
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UserUpdatePassword(),
                                    ),
                                  );
                                  provider.clearLoginFields();
                                },
                                child: const Text(
                                  'Forgot Password ?',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black)),
                            onPressed: () {
                              if (provider.loginFormKey.currentState!
                                  .validate()) {
                                provider.userLogin(
                                    provider.loginEmailController.text,
                                    provider.loginPasswordController.text,
                                    context);
                              } else {
                                return;
                              }
                            },
                            child: Container(
                              width: width,
                              height: 30,
                              decoration: const BoxDecoration(),
                              child: const Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have any account ?"),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserRegisterScreen(),
                  ),
                );
                provider.clearLoginFields();
              },
              child: const Text(
                'Signup',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
