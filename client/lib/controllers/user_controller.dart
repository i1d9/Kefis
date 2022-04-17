part of 'package:client/helpers/imports.dart';

class UserController extends GetxController {
  var userFirstName = "".obs;
  var userEmail = "".obs;
  var userPhone = "".obs;
  var userSecondName = "".obs;
  var userRole = "".obs;
  var userPassword = "".obs;
  var userConfirmPassword = "".obs;

  set setRole(String value) => userRole.value = value;
  set setFirstName(String value) => userFirstName.value = value;
  set setSecondName(String value) => userSecondName.value = value;

  set setEmail(String value) => userEmail.value = value;
  set setPhone(String value) => userPhone.value = value;

  set setPassword(String value) => userPassword.value = value;
  set setConfirmPassword(String value) => userConfirmPassword.value = value;
}