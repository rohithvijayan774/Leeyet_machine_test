import 'package:flutter/material.dart';
import 'package:leeyet_machine_test/Controllers/user_controller.dart';
import 'package:provider/provider.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

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
              height: height / 4,
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
            height: height / 1.5,
            width: width,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
              ),
              child: Consumer<UserController>(builder: (context, provider, _) {
                return Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    children: [
                      const Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Form(
                            key: provider.registerFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: provider.firstNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '* Required Field';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'First Name',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  controller: provider.lasttNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '* Required Field';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Last Name',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  controller: provider.emailController,
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
                                TextFormField(
                                  controller: provider.passwordController,
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
                                const SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.black)),
                                  onPressed: () {
                                    if (provider.registerFormKey.currentState!
                                        .validate()) {
                                      provider.registerUser(
                                          provider.emailController.text,
                                          provider.passwordController.text,
                                          provider.firstNameController.text,
                                          provider.lasttNameController.text,
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
                                        'Signup',
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
                      ),
                    ],
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
            const Text("Already have an account ?"),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                provider.clearRegisterFields();
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}