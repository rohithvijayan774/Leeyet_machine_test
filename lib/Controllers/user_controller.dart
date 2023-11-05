import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:leeyet_machine_test/Config/api.dart';
import 'package:leeyet_machine_test/Views/product_grid_view.dart';
import 'package:leeyet_machine_test/models/products_model/products_model.dart';

class UserController with ChangeNotifier {
  //-------------------For User Registration------------------------------------

  final registerFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final updatePasswordFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lasttNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> registerUser(String email, String password, String firstName,
      String lastName, context) async {
    var data = {
      "emailorphonenumber": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
    };
    var body = json.encode(data);

    response = await http.post(
      Uri.parse(registerAPI),
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    if (response!.statusCode == 200 || response!.statusCode < 299) {
      Navigator.of(context).pop();
      snackBarMessage(
          context: context,
          message: 'User registered successfully',
          color: Colors.green);
      clearRegisterFields();
    } else if (response!.statusCode == 409) {
      snackBarMessage(
          context: context,
          message: 'This email/phone already registered',
          color: Colors.red);
    } else {
      snackBarMessage(
          context: context,
          message: 'Oops... Something went wrong',
          color: const Color.fromARGB(255, 244, 67, 54));
    }
    notifyListeners();
  }

  //-------------------For User Login------------------------------------

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  var userData;

  Future<void> userLogin(String email, String password, context) async {
    var data = {
      "emailorphonenumber": email,
      "password": password,
    };
    var body = json.encode(data);

    response = await http.post(
      Uri.parse(loginAPI),
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    if (response!.statusCode == 200) {
      userData = json.decode(response!.body);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProductGridView(),
        ),
      );
      clearLoginFields();
    } else if (response!.statusCode == 401) {
      snackBarMessage(
          context: context,
          message: 'Incorrect Password',
          color: const Color.fromARGB(221, 244, 67, 54));
    } else if (response!.statusCode == 404) {
      snackBarMessage(
          context: context,
          message: 'No user found',
          color: const Color.fromARGB(221, 244, 67, 54));
    } else {
      snackBarMessage(
        context: context,
        message: 'Oops... Something went wrong',
        color: const Color.fromARGB(221, 244, 67, 54),
      );
    }
    notifyListeners();
  }

  //-------------------For User Password Update------------------------------------

  TextEditingController changePasswordEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Future<void> updatePassword(String email, String password, context) async {
    var data = {
      "emailorphonenumber": email,
      "password": password,
    };
    var body = json.encode(data);
    response = await http.put(
      Uri.parse(forgotPasswordAPI),
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    if (response!.statusCode == 200) {
      snackBarMessage(
        context: context,
        message: 'Password Updated',
        color: const Color.fromARGB(197, 76, 175, 79),
      );
      Navigator.of(context).pop();
      clearupdatePasswordFields();
    } else if (response!.statusCode == 404) {
      snackBarMessage(
        context: context,
        message: 'This Email is not registered.',
        color: const Color.fromARGB(221, 244, 67, 54),
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

  //----------------- Common ---------------------------------------------------

  Response? response;

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

  //----------------- Get Products ---------------------------------------------------

  List<ProductsModel> productsList = [];
  Future<List<ProductsModel>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      var productData = jsonDecode(response.body.toString());
      for (Map<String, dynamic> i in productData) {
        productsList.add(ProductsModel.fromJson(i));
      }
      // print('Fetch Product Successful');
      // print(productData);
      // print(productsList.length);
      return productsList;
    } else {
      // print('Error Fetching');
      return productsList;
    }
  }

  var data;
  Future<void> getProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }
}
