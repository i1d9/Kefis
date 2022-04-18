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

Future<Map<dynamic, dynamic>> addUser(Map<String, dynamic> userData) async {
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

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.

    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

Future<List<PointLatLng>> getRoute(PointLatLng origin, PointLatLng destination) async {
  PolylinePoints polylinePoints = PolylinePoints();
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapAPIKey, origin, destination);

  return result.points;
}
