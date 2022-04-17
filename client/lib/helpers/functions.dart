part of 'package:client/helpers/imports.dart';

var options = BaseOptions(
  baseUrl: 'http://10.0.3.2:4000/api',
);

Dio dio = Dio(options);

Future<Map<dynamic, dynamic>> login(String email, String password) async {
  try {
    var data = {
      "user": {"email": email, "password": password}
    };

    Response response = await dio.post("/login", data: data);

    // Write value
    storage.write(key: "user", value: jsonEncode(response.data));
    authenticationController.loadUser(response.data);
    Get.off(Home());
    return {};
  } catch (e) {
    print("Could not Login User");
    print(e);
    return {"success": false};
  }
}

Future<Map<dynamic, dynamic>> addPartner(
    Map<String, dynamic> partnerData) async {
  try {
    var data = {"partner": partnerData};
    var token = authenticationController.user["access_token"];

    dio.options.headers["Authorization"] = token;
    Response response = await dio.post("/admin/partners/new", data: data);

    return {};
  } catch (e) {
    print("Could not Add Partner");
    print(e);
    return {"success": false};
  }
}


Future<Map<dynamic, dynamic>> addUser(
    Map<String, dynamic> userData) async {
  try {
    var data = userData;
    var token = authenticationController.user["access_token"];

    dio.options.headers["Authorization"] = token;
    Response response = await dio.post("/admin/partners/new", data: data);

    return {};
  } catch (e) {
    print("Could not Add Partner");
    print(e);
    return {"success": false};
  }
}


