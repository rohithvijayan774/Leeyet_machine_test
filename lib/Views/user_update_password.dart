import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controllers/user_controller.dart';

class UserUpdatePassword extends StatelessWidget {
  const UserUpdatePassword({super.key});

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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              provider.clearupdatePasswordFields();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    const Text(
                      'OOPACKS',
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 20, bottom: 30),
                    child: Form(
                      key: provider.updatePasswordFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Change Password',
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
                            controller: provider.changePasswordEmailController,
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
                            'New Password',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: provider.newPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Required Field';
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'New Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black)),
                            onPressed: () {
                              if (provider.updatePasswordFormKey.currentState!
                                  .validate()) {
                                provider.updatePassword(
                                    provider.changePasswordEmailController.text,
                                    provider.newPasswordController.text,
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
                                  'Submit',
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
    );
  }
}
