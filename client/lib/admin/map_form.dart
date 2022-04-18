part of 'package:client/helpers/imports.dart';

class MapForm extends StatelessWidget {
  MapForm({Key? key}) : super(key: key);

  late final MapController mapController;

  late Future<List<Polyline>> polylines;

  var points = <LatLng>[
    LatLng(51.5, -0.09),
    LatLng(53.3498, -6.2603),
    LatLng(48.8566, 2.3522),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.place),
        onPressed: () async {
          var lol = await determinePosition();
          print(lol);
        },
      ),
      body: FlutterMap(
        options: MapOptions(
          onTap: (var position, LatLng point) {
            print(point);
          },
          //center: LatLng(-1.3076, 36.8148),
          //zoom: 17.0,
          center: LatLng(51.5, -0.09),
          zoom: 5.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          PolylineLayerOptions(
            polylines: [
              Polyline(points: points, strokeWidth: 4.0, color: Colors.purple),
            ],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(-1.3076, 36.8148),
                builder: (ctx) => Container(
                  child: Icon(Icons.place),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
