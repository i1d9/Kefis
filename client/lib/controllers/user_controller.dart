part of 'package:client/helpers/imports.dart';

class UserController extends GetxController {
  User login(String email, String password) {
    User p = User(token: "token", fcm: "fcm", firstName: "firstName", secondName: "secondName", phone: "phone", email: "email", role: "role");

    return p;
  }
}
