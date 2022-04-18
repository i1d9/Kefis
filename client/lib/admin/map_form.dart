part of 'package:client/helpers/imports.dart';

class MapForm extends StatelessWidget {
  MapForm({Key? key}) : super(key: key);

  late final MapController mapController;
  final mapInfo = Get.put(FlutterMapController());

  late Future<List<Polyline>> polylines;
  late PolylinePoints polylinePoints = PolylinePoints();

  var points = <LatLng>[
    LatLng(51.5, -0.09),
    LatLng(53.3498, -6.2603),
    LatLng(48.8566, 2.3522),
  ];

  var routePoints = <LatLng>[];

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.place),
        onPressed: () async {
          var lol = await determinePosition();

          var origin = const PointLatLng(-1.283532, 36.823659);
          var destination = const PointLatLng(-1.307087, 36.815419);
          //-1.283532, 36.823659 - Origin

          var foundPoints = await getRoute(origin, destination);

          for (var i = 0; i < foundPoints.length; i++) {
            var routePoint =
                LatLng(foundPoints[i].latitude, foundPoints[i].longitude);
            routePoints.add(routePoint);
          }

          mapInfo.updateNavigationRoute(routePoints);
        },
      ),
      body: Obx(() {
        return FlutterMap(
          options: MapOptions(
            onTap: (var position, LatLng point) {
              print(point);
            },
            //center: LatLng(-1.3076, 36.8148),
            //zoom: 17.0,
            center: mapInfo.centerPoint.value,
            zoom: 5.0,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            PolylineLayerOptions(
              polylines: [
                Polyline(
                    points: mapInfo.navigationRoute,
                    strokeWidth: 2.5,
                    color: Colors.purple),
              ],
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: mapInfo.selectedPoint.value,
                  builder: (ctx) => Container(
                    child: Icon(Icons.place),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
