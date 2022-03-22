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
    print(response.data);
     
     
    return {};
  } catch (e) {

    print("Could not Login User");
    print(e);
    return {"success": false};
  }
}
