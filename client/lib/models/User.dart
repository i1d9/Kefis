part of 'package:client/helpers/imports.dart';

class User {
  final String token;
  final String fcm;
  final String firstName;
  final String secondName;
  final String phone;
  final String email;
  final String role;

  User({
    required this.token,
    required this.fcm,
    required this.firstName,
    required this.secondName,
    required this.phone,
    required this.email,
    required this.role,
  });
}
