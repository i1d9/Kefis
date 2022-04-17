part of 'package:client/helpers/imports.dart';

const storage = FlutterSecureStorage();

class AuthenticationController extends GetxController {
  var access_token = ''.obs;
  var first_name = ''.obs;
  var second_name = ''.obs;
  var role = ''.obs;
  final user = <String, dynamic>{}.obs;

  loadUser(passedUser){
    
    user.addAll(passedUser);
  }
}

final authenticationController = Get.put(AuthenticationController());
