import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:leeyet_machine_test/Config/api.dart';
import 'package:leeyet_machine_test/Views/user_home_screen.dart';

class UserController extends ChangeNotifier {
  //-------------------For User Registration------------------------------------

  final registerFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final updatePasswordFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lasttNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> registerUser(
    String email,
    String password,
    String firstName,
    String lastName,
    context,
  ) async {
    var data = {
      "emailorphonenumber": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
    };
    var body = json.encode(data);

    Response response = await http.post(
      Uri.parse(registerAPI),
      body: body,
      headers: {"Content-Type": "application/json"},
    );
    print("Response : ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode < 299) {
      Navigator.of(context).pop();
      snackBarMessage(
          context: context,
          message: 'User registered successfully',
          color: Colors.green);
      clearRegisterFields();
      print('User Registered Successfull');
      print(response.body);
    } else if (response.statusCode == 409) {
      print('failed to register User');
      snackBarMessage(
          context: context,
          message: 'This email/phone already registered',
          color: Colors.red);
    } else {
      snackBarMessage(
          context: context,
          message: 'Oops... Something went wrong',
          color:const Color.fromARGB(255, 244, 67, 54));
    }
    notifyListeners();
  }

  //-------------------For User Login------------------------------------

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  Future<void> userLogin(String email, String password, context) async {
    var data = {
      "emailorphonenumber": email,
      "password": password,
    };
    var body = json.encode(data);

    Response response = await http.post(
      Uri.parse(loginAPI),
      body: body,
      headers: {"Content-Type": "application/json"},
    );
    print("Response : ${response.statusCode}");
    if (response.statusCode == 200) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const UserHomeScreen(),
        ),
      );
      clearLoginFields();
    } else if (response.statusCode == 401) {
      snackBarMessage(
          context: context,
          message: 'Incorrect Password',
          color:const Color.fromARGB(221, 244, 67, 54));
    } else if (response.statusCode == 404) {
      snackBarMessage(
          context: context,
          message: 'No user found',
          color:const Color.fromARGB(221, 244, 67, 54));
    } else {
      snackBarMessage(
        context: context,
        message: 'Oops... Something went wrong',
        color:const Color.fromARGB(221, 244, 67, 54),
      );
    }
    notifyListeners();
  }

  //-------------------For User Login------------------------------------

  TextEditingController changePasswordEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Future<void> updatePassword(String email, String password, context) async {
    var data = {
      "emailorphonenumber": email,
      "password": password,
    };
    var body = json.encode(data);
    Response response = await http.put(
      Uri.parse(forgotPasswordAPI),
      body: body,
      headers: {"Content-Type": "application/json"},
    );
    print("Response : ${response.statusCode}");
    if (response.statusCode == 200) {
      snackBarMessage(
        context: context,
        message: 'Password Updated',
        color: const Color.fromARGB(197, 76, 175, 79),
      );
      Navigator.of(context).pop();
      clearupdatePasswordFields();
    } else if (response.statusCode == 404) {
      snackBarMessage(
        context: context,
        message: 'This Email is not registered.',
        color:const Color.fromARGB(221, 244, 67, 54),
      );
    } else {
      snackBarMessage(
        context: context,
        message: 'Oops... Something went wrong',
        color: const Color.fromARGB(221, 244, 67, 54),
      );
    }
    notifyListeners();
  }

  //----------------- Common ----------------------------------------------------

  void snackBarMessage(
      {required context, required String message, required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        margin: const EdgeInsets.only(left: 10, right: 10),
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
    notifyListeners();
  }

  void clearRegisterFields() {
    firstNameController.clear();
    lasttNameController.clear();
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  void clearLoginFields() {
    loginEmailController.clear();
    loginPasswordController.clear();
    notifyListeners();
  }

  void clearupdatePasswordFields() {
    changePasswordEmailController.clear();
    newPasswordController.clear();
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }
}
