import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Utils {
  //Check if email or password is not empty at the login
  static bool isValidLogin(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }
    return true;
  }

  //Check that nothing is empty at the register
  static bool isEmptyRegister(
      String username, String email, String password, String passwordAgain) {
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        passwordAgain.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Do passwords match at the register?
  static bool passwordMatch(String password, String passwordAgain) {
    if (password == passwordAgain) {
      return true;
    } else {
      return false;
    }
  }

  //Show error toast with message
  void showToastError(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //Show success toast with msg
  void showToastSuccess(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 0, 183, 6),
        textColor: const Color.fromARGB(255, 255, 255, 255),
        fontSize: 16.0);
  }

  //Check book details
  static bool isEmptyBookDetails(
      String bookName,
      String author,
      String releaseDate,
      String category,
      String pageNumber,
      String description,
      String coverImageUrl,
      String pdfUrl) {
    if (bookName.isEmpty ||
        author.isEmpty ||
        releaseDate.isEmpty ||
        category.isEmpty ||
        pageNumber.isEmpty ||
        description.isEmpty ||
        coverImageUrl.isEmpty ||
        pdfUrl.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
