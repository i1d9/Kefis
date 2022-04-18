part of 'package:client/helpers/imports.dart';

class FlutterMapController extends GetxController {
  var selectedPoint = LatLng(-1.307087, 36.815419).obs;
  var centerPoint = LatLng(-1.307087, 36.815419).obs;
  var navigationRoute  = <LatLng>[].obs;

  void updateCenter(LatLng center) {
    centerPoint.value = center;
  }

  void updateSelectedPoint(LatLng point) {
    selectedPoint.value = point;
  }

  void updateNavigationRoute(List<LatLng> route){
    navigationRoute.value = route;
  }


}
